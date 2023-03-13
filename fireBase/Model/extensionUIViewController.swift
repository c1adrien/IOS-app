//
//  extensionUIViewController.swift
//  fireBase
//
//  Created by Adrien Cortes on 17/03/2021.
//

import Foundation
import UIKit
extension UIViewController{
//on gère le clavier une fois pour toute les vues (ce sera partout dans les view controllers)
    
    
    func miseEnPlaceDuClavier(){
        //l'observeur est lui même, le propre vue controlleur
        NotificationCenter.default.addObserver(self, selector: #selector(clavierSortie), name: UIResponder.keyboardWillShowNotification, object: nil)
        //quand on va finir le clavier
        NotificationCenter.default.addObserver(self, selector: #selector(clavierRentre), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // puis quand on tape sur la vue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rangerClavier)))
        
    }
    @objc func clavierSortie(notification: Notification){
        //on récupère la taille du clavier
        //on doit savoir que le clavier se bouge sur 0.25 secondes
        //if let keyboardSiz
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, view.frame.minY == 0{
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame.origin.y -= keyboardFrame.height
            }, completion: nil)
            
        }
        
    }
    
    @objc func rangerClavier(){
        view.endEditing(true)
        UIView.animate(withDuration: 0.25,animations:{
            self.view.frame = CGRect(x:0,y:0,width:self.view.frame.width,height: self.view.frame.height)
        },completion: nil)

        
    }
    @objc func clavierRentre(notification: Notification){
        
    }
}
