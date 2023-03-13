//
//  ChatController.swift
//  fireBase
//
//  Created by Adrien Cortes on 23/03/2021.
//

import UIKit

class ChatController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    
    var monId:String!
    var partenaire: Utilisateur!
    var messages: [Messages] = []
    var imagePartenaire: UIImage?
    var prenom:String?
    var estActif = false
    var enTrainDecrire=false
    var derniereFois = ""
    var topLbl = UILabel()
    var timer = Timer()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var zoneDeSaisie: UIView!
    @IBOutlet weak var zoneDeText: UITextView!
    @IBOutlet weak var appareilBtn: UIButton!
    @IBOutlet weak var galerieBtn: UIButton!
    
    @IBOutlet weak var zoneDeTextGaucheContrainte: NSLayoutConstraint!
    
    @IBOutlet weak var zoneDeTextHauteurContrainte: NSLayoutConstraint!
    @IBOutlet weak var zoneDeSaisieHauteurContrainte: NSLayoutConstraint!
    var UInavigationBar = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlaceDuClavier()
        zoneDeText.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .interactive
        topLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        topLbl.textAlignment = .center
        topLbl.numberOfLines = 0
        self.navigationItem.titleView = topLbl
        
       
        UInavigationBar.tintColor = .white
        UInavigationBar.barTintColor = .white
        
        
        let retourButn = UIBarButtonItem()
        retourButn.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = retourButn
        
        let nib = UINib(nibName: "MessageCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "message_cell")
        observerMessage()
        Donnees().miseAJourToken(monId, UD().getToken()!)
        
        
        Donnees().ObetenirUtilisateurSpecifique(id: monId) { (user) -> (Void) in
            if let utilisateur = user as? Utilisateur{
                self.prenom = utilisateur.prenom
                print(self.prenom)
            }
        }
        observerActivite()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        //pour cacher la tab bar sur ce vue
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func miseEnPlace(id:String,utilisateur:Utilisateur,image:UIImage?){
        self.monId = id
        self.partenaire = utilisateur
        self.imagePartenaire = image
        self.title = partenaire.prenom
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "message_cell", for: indexPath) as! MessageCell
        cell.configurerCell(monId: monId, message: messages[indexPath.row], image: imagePartenaire)
        return cell
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var hauteur: CGFloat = 80
        let largeur = collectionView.frame.width
        let message = messages[indexPath.row]
        
        if let texte = message.texte{
            hauteur = texte.hauteur(largeur: largeur, font: UIFont.systemFont(ofSize: 17)) + 80
            
        }
        
        return CGSize(width: largeur, height: hauteur)
    }
    
    func observerMessage(){
        Donnees().recevoirMessage(from: monId, to: partenaire.id) { (msg) in
            if let message = msg{
                self.messages.append(message)
                self.trierMessages()
            }
        }
        
        Donnees().recevoirMessage(from: partenaire.id, to: monId) { (msg) in
            if let message=msg{
                self.messages.append(message)
                self.trierMessages()
            }
        }
    }
    func trierMessages(){
        messages = messages.sorted(by: {$0.date<$1.date})
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            //afficher par le bas
            let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    func observerActivite(){
        let ref = Ref().databaseStatut(id: partenaire.id)
        ref.observe(.value) { (snpachot) in
            if let snap = snpachot.value as? Dictionary<String,AnyObject>{
                if let actif = snap["online"] as?Bool, let date = snap["dernier"] as? Double{
                    self.estActif = actif
                    self.derniereFois = date.dateLisiblePourMessage()
                    if let ecritA = snap["ecrit"] as? String, ecritA == self.monId{
                        self.miseAJourLbl(bool: true)
                        
                    } else{
                        self.miseAJourLbl(bool: false)
                    }
                    
                }
            }
        }
    }
    
    func miseAJourLbl(bool:Bool){
        var secondeLigne = ""
        var couleur: UIColor = .darkGray
        if bool {
            secondeLigne = "écrit..."
        }
        else{
            if estActif{
                secondeLigne = "actif"
                couleur = .darkGray
                
            }
            else{
                secondeLigne = "Vu " + derniereFois
                couleur = .red
            }
        }
        let attributed = NSMutableAttributedString(string: partenaire.prenom + "\n", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black])
        attributed.append(NSAttributedString(string: secondeLigne, attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: couleur]))
        topLbl.attributedText = attributed
                                                    
        
    }
  
}
