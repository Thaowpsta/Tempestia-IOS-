//
//  Particle.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

struct Particle {
    let x: Double
    let speed: Double
    let delay: Double
    let radius: Double
}

struct AnimatedParticleBackground: View {
    @Environment(\.tempestia) var theme

    let particles: [Particle] = (0..<40).map { _ in
        Particle(
            x: Double.random(in: 0...1),
            speed: Double.random(in: 0...1) * 1.5 + 0.5,
            delay: Double.random(in: 0...1),
            radius: Double.random(in: 0...1) * 3.0 + 1.0
        )
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let centerColors =
                    theme.isMorning
                    ? [
                        Color(hex: 0xD8CCF5), Color(hex: 0xEDE8F8),
                        theme.bgDeep,
                    ]
                    : [
                        Color(hex: 0x1E1136), Color(hex: 0x130D26),
                        theme.bgDeep,
                    ]

                let gradient = Gradient(colors: centerColors)
                context.fill(
                    Path(CGRect(origin: .zero, size: size)),
                    with: .radialGradient(
                        gradient,
                        center: CGPoint(x: size.width / 2, y: 0),
                        startRadius: 0,
                        endRadius: size.height * 0.7
                    )
                )

                let now = timeline.date.timeIntervalSinceReferenceDate
                let time = (now.truncatingRemainder(dividingBy: 30.0)) / 30.0

                for p in particles {
                    let localTime = (time * p.speed + p.delay)
                        .truncatingRemainder(dividingBy: 1.0)

                    let currentY = size.height * (1.0 - localTime)
                    let currentX =
                        (size.width * p.x) + (localTime * size.width * 0.15)

                    var alpha: Double = 1.0
                    if localTime < 0.2 {
                        alpha = localTime / 0.2
                    } else if localTime > 0.8 {
                        alpha = (1.0 - localTime) / 0.2
                    }

                    let particleColor = theme.purpleCore.opacity(alpha * 0.3)

                    context.fill(
                        Path(
                            ellipseIn: CGRect(
                                x: currentX - p.radius,
                                y: currentY - p.radius,
                                width: p.radius * 2,
                                height: p.radius * 2
                            )
                        ),
                        with: .color(particleColor)
                    )
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
