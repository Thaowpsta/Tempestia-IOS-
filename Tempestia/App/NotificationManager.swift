//
//  NotificationManager.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    func scheduleAlarm(id: UUID, time: Date, title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = subtitle
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        if #available(iOS 17.0, *) {
             WeatherBackgroundTask.shared.scheduleNextRefresh()
        }
    }
    
    func cancelAlarm(id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge, .list])
    }
}
