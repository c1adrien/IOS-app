//
//  UserNotificationDelegate.swift
//  fireBase
//
//  Created by Adrien Cortes on 24/03/2021.
//

import Foundation
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate{
    func configureUN(){
        let current = UNUserNotificationCenter.current()
        current.delegate = self
        let options: UNAuthorizationOptions = [.alert,.badge,.sound] //on demande ça pour les notifs
        current.requestAuthorization(options: options) { (sucess, err) in
            if sucess{
                print("this is a sucess")
            }
            if err != nil {
                print(err!.localizedDescription)
            }
        }
    }
    
    
    //delegate : important
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("did received : \(response.notification.request.content.userInfo)")
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("will present \(notification.request.content.userInfo)")
    }
}
