//
//  Alarm.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

struct Alarm {
    var id: UUID?
    var title: String = "" {
        didSet {
            if title.count > 10 && oldValue.count <= 10 {
                title = oldValue
            }
        }
    }
    var repeatAlarm: Bool
    var wakeUpWisdom: Bool
    var scheduledTime: Date
    var mission: MissionType
    var ringtone: String
}
