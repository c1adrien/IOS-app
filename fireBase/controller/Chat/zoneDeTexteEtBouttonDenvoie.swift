//
//  zoneDeTexteEtBouttonDenvoie.swift
//  fireBase
//
//  Created by Adrien Cortes on 23/03/2021.
//

import Foundation
import UIKit

extension ChatController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if let texte = textView.text{
            changerTailleDeZoneDeSaisie(string: texte)
        }else{
            //sinon on change comme si on avait une string vide
            changerTailleDeZoneDeSaisie(string: "")
        }
        
        if !enTrainDecrire{
            Donnees().ecrit(from: monId, to: partenaire.id)
            enTrainDecrire = true
        } else{
            timer.invalidate()
        }
        timerEcriture()
        
        
    }
    
    func timerEcriture(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (t) in
            Donnees().ecrit(from: self.monId, to: "")
            self.enTrainDecrire = false
        })
    }
    
    func changerTailleDeZoneDeSaisie(string:String){
        if string != "", zoneDeTextGaucheContrainte.constant == 90{
            UIView.animate(withDuration: 0.45) {
                self.zoneDeTextGaucheContrainte.constant = 8
                self.appareilBtn.isHidden = true
                self.galerieBtn.isHidden = true
            }
            
        }
        if string == "", zoneDeTextGaucheContrainte.constant != 90{
            UIView.animate(withDuration: 0.45) {
                self.zoneDeTextGaucheContrainte.constant = 90
                self.appareilBtn.isHidden = false
                self.galerieBtn.isHidden = false
            }
            
        }
        let hauteur = string.hauteur(largeur: zoneDeText.frame.width, font: UIFont.systemFont(ofSize: 17)) //on récupère la hauteur que l'on aurait du avoir
        //on a 50 de taille de base
        if hauteur + 16 > 50{
            self.miseAJourContrainte(contrainte: zoneDeTextHauteurContrainte, constante: hauteur)
            self.miseAJourContrainte(contrainte: zoneDeSaisieHauteurContrainte, constante: hauteur+16)
        }
        else{
            self.miseAJourContrainte(contrainte: zoneDeTextHauteurContrainte, constante: 50-16)
            self.miseAJourContrainte(contrainte: zoneDeSaisieHauteurContrainte, constante: 50)
           
        }
    }
    
    func miseAJourContrainte(contrainte:NSLayoutConstraint,constante: CGFloat){
        UIView.animate(withDuration: 0.35) {
            contrainte.constant = constante
        }
        
    }
    
    func envoyerSurFirebBase(dict:Dictionary<String,AnyObject>){
        var valeurs = dict
        let date: Double = Date().timeIntervalSince1970
        valeurs["from"] = monId as AnyObject
        valeurs["to"] = partenaire.id as AnyObject
        valeurs["date"] = date as AnyObject
        //puis on peut envoyer ça sur firebase
        
        
        if let token = partenaire.token{
            Donnees().envoyerMessage(from: monId, to: partenaire.id, valeurs: valeurs,token:token,nom:monId)
        }
        else{
            Donnees().envoyerMessage(from: monId, to: partenaire.id, valeurs: valeurs,token: nil, nom: monId)
        }

        
    }
    
    
    
    @IBAction func okBtnAction(_ sender: Any) {
        if let texte = zoneDeText.text, texte != ""{
            zoneDeText.text = ""
            envoyerSurFirebBase(dict: ["texte":texte as AnyObject])
            
        }
    }
    
    
    
    @IBAction func gallerieBtnAction(_ sender: Any) {
    }
    
    
    @IBAction func appareilBtnAction(_ sender: Any) {
    }
    
    
}
