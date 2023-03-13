//
//  ConnectController.swift
//  fireBase
//
//  Created by Adrien Cortes on 17/03/2021.
//

import UIKit
import FirebaseAuth
class ConnectController: UIViewController {

    @IBOutlet weak var container: VueArrondieAvecOmbre!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var mdpTextField: UITextField!
    @IBOutlet weak var okBoutton: BoutonArrondiAvecOmbre!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miseEnPlaceDuClavier()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        container.alpha = 0 //on cache le container
        okBoutton.alpha = 0 //on cache aussi le bouton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //si notre utilisateur est déjà authentifié
        if let id = Auth.auth().currentUser?.uid {
            renvoyerVersApp(id: id)
            
        }
        else{
            container.alpha = 1
            okBoutton.alpha = 1
        }
    }
    func renvoyerVersApp(id:String){
        let tab = MaTab()
        //tab.monId = id
        tab.setup(id: id)
        tab.modalPresentationStyle = .fullScreen
        Donnees().statut(bool: true)
        self.present(tab, animated: true, completion: nil)
        
    }
    func identication(){
        guard let mail = mailTextField.text, mail != "" else{
            uneErreur(err: "veuillez entrer une adresse mail")
            return}
        guard let pass = mdpTextField.text, pass != "" else{
            uneErreur(err: "entrez un mdr")
            return}
        Auth.auth().signIn(withEmail: mail, password: pass) { (user, error) in
            if let err = error{
                self.uneErreur(err: err.localizedDescription)
            }else if let id = user?.user.uid{
                //on va envoyer vers l'appliction
                self.view.supprimerActivity()
                self.renvoyerVersApp(id: id)
                
                
            } else{
                self.uneErreur(err: "réésayez plus tard")
            }
        }
        
    }
    func uneErreur(err:String){
        view.supprimerActivity()
        Popup().messageSimple(err, self)
    }

    @IBAction func okBouttonAction(_ sender: Any) {
        view.createActivity()
        view.endEditing(true)
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (timer) in
            self.identication()
        }
    }
    
    
    
    @IBAction func creerCompteAction(_ sender: Any) {
        //pour présenter en plein écran
        let vc = CreerCompteController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
