//
//  WakeyApp.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI
import UIKit
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    var navigateToQuiz = NavigateToQuiz()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        print("Your code here")
        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]

        // 1
        if
            let notification = notificationOption as? [String: AnyObject] {
        }
        else {
            print("normally launched")
        }
        return true
    }
    
    func application(
      _ application: UIApplication,
      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
      fetchCompletionHandler completionHandler:
      @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("doubt it")
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Wakey")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    // 1
    print(response)
    let alarmId = response.notification.request.content.userInfo["alarmId"] as! String?
    print("ringingAlarmId:", alarmId)

    let context = self.persistentContainer.viewContext
    var alarms: [AlarmEntity] = []
    alarms = try! context.fetch(AlarmEntity.fetchRequest())
    
    var currentAlarm = try! alarms.first(where: { $0.id == UUID(uuidString: alarmId as! String) })!

    if currentAlarm.wakeUpWisdom {
        navigateToQuiz.wakeUpWisdom = true
    }
    if currentAlarm.mission == MissionType.quiz.rawValue {
        navigateToQuiz.navigateToQuiz = true
    }
    else {
        navigateToQuiz.navigateToTyping = true
    }
    navigateToQuiz.ringtone = currentAlarm.ringtone!

    completionHandler()
  }
}

@main
struct WakeyApp: App {
    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AlarmListView()
                .environmentObject(appDelegate.navigateToQuiz)
                .environmentObject(AlarmViewModel())
                .environmentObject(QuizViewModel())
        }
    }
}
