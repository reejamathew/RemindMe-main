//
//  NotificationManager.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//

import Foundation
import UserNotifications

class NotificationsManager: NSObject {

    static let shared = NotificationsManager()
    
    
    func add(date: Date, title: String, text: String){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        //content.userInfo = ["value": "Data with local notification"]
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        let request = UNNotificationRequest(identifier: "LOCAL_NOTIFICATIONS_JOBS", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
    
    func setPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
