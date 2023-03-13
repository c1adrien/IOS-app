//
//  Utilisateurs.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit

class Utilisateur{
  

    private var _id:String!
    private var _prenom:String!
    private var _nom:String!
    private var _email:String?
    private var _imageurl: String?
    private var _accueil:String!
    private var _token:String?
    
    var id:String{
        return _id
    }
    var prenom:String{
        return _prenom
    }
    var nom:String{
        return _nom
    }
    var mail:String?{
        return _email
    }
    var imageurl:String?{
        return _imageurl
    }
    var accueil: String{
        return _accueil
    }
    var token:String?{
        return _token
    }
    
    func miseAjour(cle:String,valeur:String){
        switch cle {
        case "prenom":
            self._prenom = valeur
        case "nom":
            self._nom = valeur
        case "acceuil":
            self._accueil = valeur
        case "profilUrl":
            self._imageurl = valeur
        default:
            break
        }
    }
    
    init(id:String,prenom:String,nom:String,mail:String?,url:String?,accueil:String,token:String?){
        self._accueil = accueil
        self._id = id
        self._email = mail
        self._nom = nom
        self._prenom = prenom
        self._imageurl = url
        self._token = token

}
}
