//
//  Util.swift
//  ShoppingListAlerts
//
//  Created by Amy Roberson on 4/17/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class Util {
    
    static func scheduleNotificationCustom(at date: Date, title: String, subtitle: String?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().delegate = appDelegate
        let components = getDateComponets(from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        if subtitle != nil {
            content.body = subtitle!
        } else {
            content.body = "Remember to \(title)"
        }
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myCategory"
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("The error: \(error)")
            }
            UNUserNotificationCenter.current().getPendingNotificationRequests { (reqs) in
                print("1 \(reqs)")
            }
            UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { (req) in
                print("2 \(req)")
            })

        }
    }
    
    //returns dd/mm/yyyy m/h
    static func getDateComponets(from date: Date) -> DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        
        let firstComponents = calendar.dateComponents(in: .current, from: date)
        let componets = DateComponents(calendar: calendar, timeZone: .current, year: firstComponents.year, month: firstComponents.month, day: firstComponents.day, hour: firstComponents.hour, minute: firstComponents.minute)
        
        return componets
    }
    
    
}
