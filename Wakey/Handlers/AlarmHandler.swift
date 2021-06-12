//
//  AlarmHandler.swift
//  Wakey
//
//  Created by Student on 07.06.21.
//

import Foundation
import UserNotifications

class AlarmHandler {
    static func registerPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("access granted")
            }
            else {
                print("access denied")
            }
        }
    }
    
    func scheduleAlarm(alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Wakey!"
        content.body = "Wake up, motherfucker!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["mission": alarm.mission.rawValue]
        content.sound = .criticalSoundNamed( UNNotificationSoundName(rawValue: alarm.ringtone.path))
        
        let date = Calendar.current.dateComponents([.day, .hour, .minute], from: alarm.scheduledTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: alarm.id!.uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
}
