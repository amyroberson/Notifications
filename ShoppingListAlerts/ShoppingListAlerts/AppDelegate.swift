//
//  AppDelegate.swift
//  ShoppingListAlerts
//
//  Created by Amy Roberson on 4/12/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
            if !granted {
                print("No Notifications will be sent!")
            }
        }
        let action = UNNotificationAction(identifier: "remindMeLater", title: "Remind me later", options: [])
        let category = UNNotificationCategory(identifier: "myCategory", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
       
        
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindMeLater" {
            let newDate = Date(timeInterval: 3600, since: Date())
            // update notification - create new notification with newDate
            Util.scheduleNotificationCustom(at: newDate, title: "Remember", subtitle: nil)
        }
    }
     
    // allows notifications when in the app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}

