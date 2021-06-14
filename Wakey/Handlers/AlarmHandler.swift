//
//  AlarmHandler.swift
//  Wakey
//
//  Created by Student on 07.06.21.
//

import Foundation
import UserNotifications

class AlarmHandler {
    let center = UNUserNotificationCenter.current()
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
        let content = UNMutableNotificationContent()
        content.title = "Wakey!"
        content.body = "Wake up, motherfucker!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["alarmId": alarm.id!.uuidString]
        
        content.sound = .criticalSoundNamed( UNNotificationSoundName(rawValue: resolvePath(alarm: alarm)))
        
        let date = Calendar.current.dateComponents([.day, .hour, .minute], from: alarm.scheduledTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: alarm.id!.uuidString, content: content, trigger: trigger)
        
        self.center.add(request)
    }
    
    func resolvePath(alarm: Alarm) -> String {
        let index = Ringtones.ringtone.firstIndex(where: { $0.title == alarm.ringtone })
        return Ringtones.ringtone[index!].path
    }
    
    func removeAlarm(alarmIdentifier: String) {
        self.center.getPendingNotificationRequests { (notificationRequests) in
           var identifiers: [String] = []
           for notification:UNNotificationRequest in notificationRequests {
               if notification.identifier == alarmIdentifier {
                  identifiers.append(notification.identifier)
               }
           }
            self.center.removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    func rescheduleAlarm(alarm: Alarm) {
        self.scheduleAlarm(alarm: alarm)
    }
}
