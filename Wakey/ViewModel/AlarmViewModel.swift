//
//  AlarmViewModel.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

final class AlarmViewModel : ObservableObject {
    let context = AppDelegate().persistentContainer.viewContext
    let handler = AlarmHandler()
    @Published var alarmData: [AlarmEntity] = []
    
    init() {
        self.loadCoreData()
    }
    
    func loadCoreData() {
        do {
            alarmData = try context.fetch(AlarmEntity.fetchRequest())
        }
        catch {
            print("could not load data")
        }
    }
    
    @Published var alarm = Alarm(
        title: "",
        repeatAlarm: false,
        wakeUpWisdom: false,
        scheduledTime: Date.init(),
        mission: Missions.mission[0].type,
        ringtone: Ringtones.ringtone[0].title) {
        didSet {
            self.calculateTimeToRing()
        }
    }
    
    @Published var timeToRing: DateComponents = DateComponents(day: 0, hour: 0, minute: 0)
    func calculateTimeToRing() {
        let date = Calendar.current.date(byAdding: .minute, value: 1, to: self.alarm.scheduledTime)!
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date.init(), to: date)
        timeToRing.day = diffComponents.day
        timeToRing.hour = diffComponents.hour
        timeToRing.minute = diffComponents.minute
    }
    
    func deleteAlarm(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let alarmToDelete = alarmData[index]
        handler.removeAlarm(alarmIdentifier: alarmToDelete.id!.uuidString)
        context.delete(alarmToDelete)
        try! context.save()
        loadCoreData()
    }
    
    func addAlarm() {
        alarm.id = UUID()
        handler.scheduleAlarm(alarm: alarm)
        saveAlarmInCoreData()
        loadCoreData()
    }
    
    func saveAlarmInCoreData() {
        let alarmEntity = getAlarmEntityFromAlarmModel()
        try! context.save()
    }
    
    func getAlarmEntityFromAlarmModel() -> AlarmEntity {
        let alarmEntity = AlarmEntity(context: context)
        alarmEntity.id = alarm.id!
        alarmEntity.isActive = true
        //TODO add isActive property to Alarm Model
        alarmEntity.mission = alarm.mission.rawValue
        alarmEntity.repeatAlarm = alarm.repeatAlarm
        alarmEntity.ringtone = alarm.ringtone
        alarmEntity.wakeUpWisdom = alarm.wakeUpWisdom
        alarmEntity.scheduledTime = alarm.scheduledTime
        return alarmEntity
    }
}
