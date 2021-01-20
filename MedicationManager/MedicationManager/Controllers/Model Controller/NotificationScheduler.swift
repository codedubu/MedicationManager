//
//  NotificationScheduler.swift
//  MedicationManager
//
//  Created by River McCaine on 1/20/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotifications(medication: Medication) {
        guard let timeofDay = medication.timeOfDay,
              let id = medication.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "REMINDER!"
        content.body = "It's time to take your \(medication.name ?? "medication")."
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeofDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notifcation request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification(medication: Medication) {
        guard let id = medication.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
} // End of class
