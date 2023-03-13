//
//  Profil.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import UIKit
import FirebaseAuth
class Profil: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var monId : String!
    var picker = UIImagePickerController()
    
    
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var prenomTf: UITextField!
    @IBOutlet weak var nomTf: UITextField!
    
    @IBOutlet weak var messageTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Donnees().ObetenirUtilisateurSpecifique(id: monId) { (utilisateur) -> (Void) in
            
            if let user = utilisateur{
                self.prenomTf.text = user.prenom
                self.nomTf.text = user.nom
                self.messageTf.text = user.accueil
                self.photo.telecharger(urlString: user.imageurl)
                
            }
            else{
                print("erreur")
            }
        }
        picker.delegate = self
        picker.allowsEditing = true
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(camera)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rangerClavier)))

        // Do any additional setup after loading the view.
    }
    @objc func camera(){
        Popup().camera(controller: self, picker: picker)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        if let original = info[.originalImage] as? UIImage{
            image = original
        }
        else if let edited = info[.editedImage] as? UIImage{
            image=edited
        }
        if let img=image{
            self.photo.image=img //on change la photo
            stockage().sauvegarderProfil(image: img, id: monId)
        }
        picker.dismiss(animated: true, completion: nil)
    }


    @IBAction func seDeconnecter(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch  {
            Popup().messageSimple("erreur", self)
        }
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func sauvegarder(_ sender: Any) {
        var dict = Dictionary<String,AnyObject>()
        if let prenom = prenomTf.text, prenom != "" {
            dict["prenom"] = prenom as AnyObject
        }
        if let nom = nomTf.text, nom != "" {
            dict["nom"] = nom as AnyObject
        }
        if let accueil = messageTf.text, accueil != "" {
            dict["acceuil"] = accueil as AnyObject
        }
        let ref = Ref().dataBaseUtilisateurSpecfique(id: monId)
        ref.updateChildValues(dict) //aussi simplement que cela LOL --- c'est SImple
        
    }
    
}
