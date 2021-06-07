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
                print("harsh")
            }
            else {
                print("sad")
            }
        }
    }
    
    static func scheduleAlarm() {
        print("im in")
         let center = UNUserNotificationCenter.current()
         
        let content = UNMutableNotificationContent()
        content.title = "Wakey!"
        content.body = "Wake up, motherfucker!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["sad": "harsh"]
        content.sound = .criticalSoundNamed( UNNotificationSoundName(rawValue: "harshness.mp3"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
     }
}
