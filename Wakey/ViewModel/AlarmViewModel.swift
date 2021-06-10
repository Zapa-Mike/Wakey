//
//  AlarmViewModel.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

final class AlarmViewModel : ObservableObject {
    let handler = AlarmHandler()
    @Published var alarm = Alarm(title: "",
                                 repeatAlarm: false,
                                 wakeUpWisdom: false,
                                 scheduledTime: Date.init(),
                                 mission: Mission.quiz,
                                 ringtone: Ringtone(
                                    title: "Stormy Classical",
                                    path: "harshness.mp3")) {
        didSet {
            self.calculateTimeToRing()
        }
    }
    
    @Published var timeToRing: DateComponents = DateComponents(hour: 0, minute: 0, second: 0)
    func calculateTimeToRing() {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.init(), to: alarm.scheduledTime)
        timeToRing.hour = diffComponents.hour
        timeToRing.minute = diffComponents.minute

    }
    func scheduleAlarm() {
        handler.scheduleAlarm(alarm: alarm)
    }
}
