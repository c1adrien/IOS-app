//
//  popUp.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit

class Popup{
    
    func camera(controller: UIViewController,picker:UIImagePickerController){
        let popup = UIAlertController(title: "Que voulez vous utiliser ? ", message: nil, preferredStyle: .alert)
        let photo = UIAlertAction(title: "appareil photo", style: .default) { (action) in
            picker.sourceType = .camera
            controller.present(picker, animated: true, completion: nil)
        }
        let galerie = UIAlertAction(title: "Galerie de photos", style: .default) { (action) in
            picker.sourceType = .photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }
        let annuler = UIAlertAction(title: "annuler", style: .cancel, handler: nil)
        popup.addAction(photo)
        popup.addAction(galerie)
        popup.addAction(annuler)
        
        controller.present(popup, animated: true, completion: nil)
    }
    
    func messageSimple(_ message:String,_ controller: UIViewController){
        let popup = UIAlertController(title: "erreur", message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        popup.addAction(alert)
        controller.present(popup, animated: true, completion: nil)
    }
}
