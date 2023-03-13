//
//  Donnees.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class Donnees{
    
    
    func ObetenirUtilisateurSpecifique(id:String,completion:UtilisateurCompletion?){
        let ref = Ref().dataBaseUtilisateurSpecfique(id: id)
        //un snapchot a une clé et une valeur. La cle ça va etre id et snapchot ça va être tout le reste
        ref.observe(.value) { (snapchot) in
            if let dict = snapchot.value as? Dictionary<String,AnyObject>{
                let utilisateurs = self.convertirDictEnUser(cle: snapchot.key, dict: dict)
                print(dict)
                completion?(utilisateurs)
                
            }else{
                print("erreur")
                completion?(nil)
            }
            
            
        }
    }
    
    
    
    
    //on a la clef qui sert bien pour se connecter
    func convertirDictEnUser(cle:String, dict:Dictionary<String,AnyObject>)->Utilisateur?{
        guard let prenom = dict["prenom"] as? String else{return nil}
        guard let nom = dict["nom"] as? String else{return nil}
        let mail = dict["mail"] as? String//vu que peut être nil
        let imageurl = dict["profilUrl"] as? String
        guard let accueil = dict["acceuil"] as? String else{return nil}
        let token = dict["token"] as? String
        let utilisateur = Utilisateur(id: cle, prenom: prenom, nom: nom, mail: mail, url: imageurl, accueil: accueil,token: token)
        
        
        
        return utilisateur
    }
    
    func obtenirTous(id:String, completion: UtilisateurCompletion?){
        let ref = Ref().databaseUtilisateurs
        //on recoit un snapchot pour chaque enfant : chaque utilisateur ajouté
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject>, snapshot.key != id{
                let utilisateur = self.convertirDictEnUser(cle: snapshot.key, dict: dict)
                completion?(utilisateur)
            }else{
                completion?(nil)
            }
        }
    }
    
    
    func obtenirChangementUtilisateur(id:String,completion:changementCompletion?){
        let ref = Ref().dataBaseUtilisateurSpecfique(id: id)
        //on observe un changement
        ref.observe(.childChanged) { (snapchot) in
            if let valeur = snapchot.value as? String{
                completion?(snapchot.key,valeur)
            }
            else{
                completion?(nil,nil)
            }
        }
    }
    func envoyerMessage(from:String, to:String,valeurs:Dictionary<String,AnyObject>,token:String?,nom:String){
        let ref = Ref().databaseMessageEnvoie(from: from, to: to)
        //le childByAutoId permet d'avoir un id unique et empèche les pb à ce niveau la
        ref.childByAutoId().updateChildValues(valeurs)
        
        let refFrom = Ref().databaseAmisSpécifique(from: from, to: to)
        refFrom.updateChildValues(valeurs)
        
        let refTo = Ref().databaseAmisSpécifique(from: to, to: from)
        refTo.updateChildValues(valeurs)
        //envoyer la notification
        guard let tkn = token else{return}
        let title = "Notification"
        let body = valeurs["texte"] as! String
        //let token = "clI438n0iEBVod7vWMV329:APA91bEiQlFzmz_KcKLZ36eP2qoz6bgCv16O07KfWY81CZTEu1i1i36tQ4wN2XkZp7spzHAduuGU_0KLD8rsZ7RCohurgd5nDtmCRip12BkYeL0M0QcOzYO_h82Gr5T_r27cMKg9lVcb"
        FireMessaging().sendSingleMessage(tkn, title, body, "test", 1)
    }
    func miseAJourToken(_ id: String, _ token :String){
        let ref = Ref().dataBaseUtilisateurSpecfique(id: id)
        ref.updateChildValues(["token":token])
    }
    
    func convertirDictEnMessage(cle:String, dict:Dictionary<String,AnyObject>)->Messages?{
        guard let from = dict["from"] as? String else{return nil}
        guard let to = dict["to"] as? String else{return nil}
        guard let date = dict["date"] as? Double else{return nil}
        let texte = dict["texte"] as? String
        let imageUrl = dict["imageUrl"] as? String
        let hauteur = dict["hauteur"] as? Double
        let largeur = dict["largeur"] as? Double
        
        let message = Messages(id: cle, from: from, to: to, date: date, texte: texte, imageUrl: imageUrl, hauteur: hauteur, largeur: largeur)
        return message
    }
    
    func recevoirMessage(from:String, to:String, completion:((_ message : Messages?)->Void)?){
        let ref = Ref().databaseMessageEnvoie(from: from, to: to).queryLimited(toLast: 10)
        ref.observe(.childAdded) { (snapchot) in
            if let dict = snapchot.value as? Dictionary<String,AnyObject>{
                completion?(self.convertirDictEnMessage(cle: snapchot.key, dict: dict))
            }
        }
        
        
        
        
    }
    
    func dernierMessage(id:String,completion:((_ dernier:DernierMessage?)->Void)?){
        let ref = Ref().databaseMesAmis(id: id)
        ref.observe(.childAdded) { (snapshot) in
            print(snapshot)
            guard let dict = snapshot.value as? Dictionary<String,AnyObject> else{return}
            guard let date = dict["date"] as? Double else{return}
            let texte = dict["texte"] as? String //optionnel
            self.ObetenirUtilisateurSpecifique(id: snapshot.key) { (user) -> (Void) in
                if let utilisateur = user {
                    completion?(DernierMessage(date: date, texte: texte, utilisateur: utilisateur))
                }
                else{
                    completion?(nil)
                }
            }
            
            
            
            
        }
    }
    func obtenirChangementDeMessage(from:String,to:String,completion:((_ cle: String?,_ valeur:AnyObject?)->Void)?){
        let ref = Ref().databaseAmisSpécifique(from: from, to: to)
        ref.observe(.childChanged) { (snpachot) in
            if let valeur = snpachot.value as? AnyObject{
                completion?(snpachot.key,valeur)
            }
        }
        
        
    }
    
    func statut(bool:Bool){
        if let id = Auth.auth().currentUser?.uid{
            let ref = Ref().databaseStatut(id: id)
            let dict : Dictionary<String,AnyObject> = [
                "online":bool as AnyObject,
                "dernier":Date().timeIntervalSince1970 as AnyObject]
            ref.updateChildValues(dict)
        }
       
    }
    
    func ecrit(from:String, to:String){
        let ref = Ref().databaseStatut(id: from)
        let dict :Dictionary<String,AnyObject> = [
            "ecrit":to as AnyObject]
        ref.updateChildValues(dict)
    }
}
