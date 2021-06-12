//
//  Alarm.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

struct Alarm {
    var id: UUID?
    var title: String
    var repeatAlarm: Bool
    var wakeUpWisdom: Bool
    var scheduledTime: Date
    var mission: Mission
    var ringtone: Ringtone
}
