//
//  ref.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class Ref {
    //Database
    //notre constante de base
    let databaseBase = Database.database().reference()
    
    //on va avoir besoin de récupérer des références de database
    var databaseUtilisateurs: DatabaseReference{
        return databaseBase.child("utilisateurs")
    }
    
    func dataBaseUtilisateurSpecfique(id:String)->DatabaseReference{
        return databaseUtilisateurs.child(id)
        
    }
    
    func databaseStatut(id:String)->DatabaseReference{
        return databaseUtilisateurs.child(id).child("statut")
    }

  //  func databaseDernierMessageUtilisateur(id:String)->DatabaseReference{
   //     return databaseUtilisateurs.child(id).child("amis")
  //  }
    
    
    var databaseAmis:DatabaseReference{
        databaseBase.child("amis")
    }
    
    func databaseMesAmis(id:String)->DatabaseReference{
        return databaseAmis.child(id)
    }
    func databaseAmisSpécifique(from:String,to:String)->DatabaseReference{
        return databaseAmis.child(from).child(to)
    }
    //messages
    
    var databaseMessage: DatabaseReference{
        return databaseBase.child("messages")
    }
    
    func databaseMessageEnvoie(from:String,to:String)->DatabaseReference{
        //annuaire à toutes les personnes à qui j'ai envoyé un message 
        return databaseMessage.child(from).child(to)
    }
    
    
    
    
    
    
    
    //Stockage
    let stockageBase = Storage.storage().reference()
    var stockageProfil: StorageReference{
        return stockageBase.child("profil")
    }
    
    func stockageProfilSpecifique(id:String)->StorageReference{
        return stockageProfil.child(id)
    }
}
