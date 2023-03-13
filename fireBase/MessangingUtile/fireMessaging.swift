//
//  fireMessaging.swift
//  fireBase
//
//  Created by Adrien Cortes on 24/03/2021.
//

import Foundation
import FirebaseMessaging

class FireMessaging{
    let key = "key=" + "AAAA5jrYbAQ:APA91bHNCUfP5hOifjpnKBp5WwWVJKRWFDBF5DKF-pJM05KhfhLRxC9aJbwmlGIyXz8m0TwRmqQ1-F_o90qwrX69c-Osb3jtIdpUhMpGGmQ7ij-q3qYXmia6fF_nzKsajNAo8hpUoIyN"
    //lien pour pouvoir envoyer un message
    let singleMessageUrl = "https://fcm.googleapis.com/fcm/send"
    
    func get_params(_ to:String, _ title:String, _ body:String, _ ref:String, _ badge :Int )->[String:Any]{
        return ["to":to as Any,
                "notification":["badge":badge, "title":title,"body":body,"ref":ref] as Any
        ]
    }
    
    func sendSingleMessage(_ to:String,_ title:String,_ body:String, _ ref:String,_ badge:Int){
        let params = get_params(to, title, body, ref, badge)
        //on va essayer d'envoyer une notification ici
        do {
            let bodyNotif = try JSONSerialization.data(withJSONObject: params, options: [.prettyPrinted])
            guard let url = URL(string: singleMessageUrl) else{return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = bodyNotif
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(key, forHTTPHeaderField: "Authorization")
            task(request)
        } catch  {
            print(error.localizedDescription)
        }
       
        
    }
    func task(_ request : URLRequest){
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data as Any)
            print(response as Any)
            print("erreur: \(error as Any)")
            self.lecture(data: data!)
        }.resume()
    }
    
    func lecture(data: Data){
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
    }
    
}

