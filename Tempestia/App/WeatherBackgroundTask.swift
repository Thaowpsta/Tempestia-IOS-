//
//  WeatherBackgroundTask.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//

import BackgroundTasks
import Foundation
import SwiftData
import Swinject
import UserNotifications

@available(iOS 17.0, *)
class WeatherBackgroundTask {
    static let shared = WeatherBackgroundTask()

    let taskId = "com.tempestia.weather.update"

    func scheduleNextRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: taskId)
        request.earliestBeginDate = Calendar.current.date(
            byAdding: .hour,
            value: 1,
            to: Date()
        )

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }

    func performWeatherUpdate() async {
        guard let repository = DependencyInjector.shared.container.resolve(WeatherRepositoryProtocol.self),
              let locationTracker = DependencyInjector.shared.container.resolve(LocationTrackerProtocol.self) else {
            scheduleNextRefresh()
            return
        }

        do {
            var query: String = "Alexandria"
            
            do {
                let location = try await locationTracker.getCurrentLocation()
                query = "\(location.latitude),\(location.longitude)"
            } catch {
                let container = try ModelContainer(for: FavoriteLocation.self)
                let context = ModelContext(container)

                var descriptor = FetchDescriptor<FavoriteLocation>(sortBy: [
                    SortDescriptor(\.addedAt, order: .reverse)
                ])
                descriptor.fetchLimit = 1

                if let targetCity = try context.fetch(descriptor).first {
                    query = "\(targetCity.latitude),\(targetCity.longitude)"
                }
            }

            let weather = try await repository.fetchWeather(
                query: query,
                days: 1
            )

            let center = UNUserNotificationCenter.current()
            let pendingRequests = await center.pendingNotificationRequests()

            for request in pendingRequests {
                let newContent = UNMutableNotificationContent()
                newContent.title = "Tempestia Daily Summary"
                newContent.body = "Expect \(weather.conditionText) today. High: \(weather.maxTemp.toAppTemp()) | Low: \(weather.minTemp.toAppTemp())."
                newContent.sound = .default

                let newRequest = UNNotificationRequest(
                    identifier: request.identifier,
                    content: newContent,
                    trigger: request.trigger
                )
                try? await center.add(newRequest)
            }
        } catch {
            print("Background fetch failed: \(error)")
        }

        scheduleNextRefresh()
    }
}
