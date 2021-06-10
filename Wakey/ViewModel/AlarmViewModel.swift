//
//  AlarmViewModel.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

final class AlarmViewModel : ObservableObject {
    let handler = AlarmHandler()
    @Published var alarm = Alarm(title: "", repeatAlarm: false, scheduledTime: Date.init(), mission: Mission.quiz)
    
    func scheduleAlarm() {
        handler.scheduleAlarm(alarm: alarm)
    }
}
