//
//  Notifications.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 7/3/21.
//

import Foundation
import UIKit

class Notifications {
    
    static func showNotification(title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
