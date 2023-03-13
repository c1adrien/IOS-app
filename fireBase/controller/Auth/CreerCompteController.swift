//
//  CreerCompteController.swift
//  fireBase
//
//  Created by Adrien Cortes on 17/03/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreerCompteController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var prenomTextField: UITextField!
    
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var motTextField: UITextField!
    
    @IBOutlet weak var mot2TextField: UITextField!
    
    
    //appareil photo
    var picker = UIImagePickerController()
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlaceDuClavier()
        picker.delegate = self
        picker.allowsEditing = true
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(demanderPhoto)))
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        mailTextField.delegate = self
        motTextField.delegate = self
        mot2TextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //cela permet de fermer le clavier quand on appuie sur done
        textField.resignFirstResponder()
        return true
    }
    @objc func demanderPhoto(){
        Popup().camera(controller: self, picker: picker)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let imageChangee = info[.editedImage] as? UIImage{
            image = imageChangee
            photo.image = imageChangee
        }
        if let imageOriginale = info[.originalImage] as? UIImage{
            image = imageOriginale
            photo.image = imageOriginale
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uneErreur(string:String){
        view.supprimerActivity()
        Popup().messageSimple(string, self)
    }
    
    
    
    func enregistrer(){
        guard let prenom = prenomTextField.text, prenom != "" else{
            uneErreur(string: "prenom")
            return}
            
        guard let nom = nomTextField.text, nom != "" else{
            uneErreur(string: "nom")
            return}
        guard let mail = mailTextField.text, mail != "" else{
            uneErreur(string: "mail")
            return}
        guard let mot = motTextField.text, mot != "" else{
            uneErreur(string: "mdp")
            return}
        guard let mot2 = mot2TextField.text, mot2 != "" else{
            uneErreur(string: "mdp2")
            return}
            
        guard mot2 == mot else{
            uneErreur(string: "les mdp ne sont pas identiques")
            return
        }
        //Authen
        //on enregistre utilisateur ds database et on doit aussi stocker sa valeur ds le storage (on a un id -> on peut travailler  sur le storage)
        Auth.auth().createUser(withEmail: mail, password: mot) { (user, err) in
            if let erreur = err {
                self.uneErreur(string: erreur.localizedDescription)
            }
            else{
                //si jamais on a un uid
                if let id = user?.user.uid{
                    let dict: Dictionary<String,AnyObject> = ["prenom":prenom as AnyObject,
                                                              "nom":nom as AnyObject,
                                                              "mail":mail as AnyObject,
                                                              "acceuil":"j'aime camelot" as AnyObject
                    ]
                    let ref = Ref().dataBaseUtilisateurSpecfique(id: id)
                    ref.updateChildValues(dict) { (error, reference) in
                        if let err = error{
                            self.uneErreur(string: err.localizedDescription)
                        }
                        else{//enregistrer l'image et passer à l'app
                            stockage().sauvegarderProfil(image: self.image, id: id)
                            self.view.supprimerActivity()
                            let tab = MaTab()
                            tab.setup(id: id)
                            Donnees().statut(bool: true)
                            tab.modalPresentationStyle = .fullScreen
                            self.present(tab, animated: true, completion: nil)
                        }
                    }
                    
                }
                else{
                    Popup().messageSimple("veuillez réessayer plus tard", self)
                }
            }
        }
     
        
    }
    
    @IBAction func okBouttonAction(_ sender: Any) {
        view.endEditing(true)
        view.createActivity()
        
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (time) in
            self.enregistrer()
        }
       
            

    }
    
    @IBAction func retourAction(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}
