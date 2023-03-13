//
//  stockage.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit
import FirebaseStorage


class stockage{
    
    func sauvegarderProfil(image: UIImage?,id:String){
        guard let monImage = image else{return}
        guard let imageTransformee = monImage.jpegData(compressionQuality: 0.1)else{return}//retourne en JPEG
        
        let ref = Ref().stockageProfilSpecifique(id: id)
        ref.putData(imageTransformee, metadata: nil) { (url, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else{
                ref.downloadURL { (url, err) in
                    if err == nil, let urlString = url?.absoluteString{
                        let ref = Ref().dataBaseUtilisateurSpecfique(id: id)
                        ref.updateChildValues(["profilUrl":urlString])
                        
                    }
                }
            }
    }
}
}
