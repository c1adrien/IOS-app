//
//  MessagingDelegate.swift
//  fireBase
//
//  Created by Adrien Cortes on 24/03/2021.
//

import Foundation
import FirebaseCore
import FirebaseMessaging

extension AppDelegate: MessagingDelegate{
    //quand on reçoit un token
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("token recived : \(fcmToken)")
        UD().setToken(fcmToken!)
       
        
    }
    
    func configureMessaging(){
        Messaging.messaging().delegate = self
        //Messaging.messaging().shouldEstablishDirectChannel = true
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("message recived : \(userInfo)")
    }
}
