//
//  WakeyTests.swift
//  WakeyTests
//
//  Created by Student on 06.06.21.
//

import XCTest
@testable import Wakey

class WakeyTests: XCTestCase {
    let api = WakeupWisdomAPI()
    let alarmHandler = AlarmHandler()
    let notificationCenter = UNUserNotificationCenter.current()
    
    func testGetWakeupWisdom() {
        let expectation = self.expectation(description: "Async Complete")
        
        api.getWakeupWisdom {
            switch $0 {
            case let .success(response):
                XCTAssertEqual(response.contents.quotes.count, 1)
                XCTAssertEqual(response.contents.quotes[0].language, "en")
            case let.failure(error): XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testScheduledAlarmIsPendingInNotificationCenter() {
        //Arrange
        let alarm = Alarm(id: UUID(), title: "test alarm", repeatAlarm: false, wakeUpWisdom: false, scheduledTime: Date(timeInterval: 1000, since: Date.init()), mission: MissionType.quiz, ringtone: "Stormy Classical")
        var alarmScheduled = false
        
        //Act
        alarmHandler.scheduleAlarm(alarm: alarm)
        
        
        //Assert
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            let identifier: String = alarm.id!.uuidString
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == identifier {
                    alarmScheduled = true
                }
            }
            XCTAssert(alarmScheduled)
        }
    }
    
    func testScheduleAlarmThenDelete() {
        //Arrange
        let alarm = Alarm(id: UUID(), title: "test alarm", repeatAlarm: false, wakeUpWisdom: false, scheduledTime: Date(timeInterval: 1000, since: Date.init()), mission: MissionType.quiz, ringtone: "Stormy Classical")
        var alarmScheduled = true
        
        //Act
        alarmHandler.scheduleAlarm(alarm: alarm)
        alarmHandler.removeAlarm(alarmIdentifier: alarm.id!.uuidString)
        
        //Assert
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            let identifier: String = alarm.id!.uuidString
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == identifier {
                    alarmScheduled = false
                }
            }
            XCTAssertFalse(alarmScheduled)
        }
    }
    
    func testRingtonePathResolvedForScheduledAlarm() {
        //Arrange
        let alarm = Alarm(id: UUID(), title: "test alarm", repeatAlarm: false, wakeUpWisdom: false, scheduledTime: Date(timeInterval: 1000, since: Date.init()), mission: MissionType.quiz, ringtone: "Stormy Classical")
        
        //Act
        let ringtonePath = alarmHandler.resolvePath(alarm: alarm)
        
        //Assert
        XCTAssertEqual(ringtonePath, "harshness.mp3")
    }
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
