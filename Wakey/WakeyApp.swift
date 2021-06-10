//
//  WakeyApp.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI
import UIKit

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
            navigateToQuiz.navigate = true
        }
        else {
           // navigateToQuiz.navigate = true
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
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    navigateToQuiz.navigate = true
    // 1
    let userInfo = response.notification.request.content.userInfo
    
    
    // 4
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
        }
    }
}
