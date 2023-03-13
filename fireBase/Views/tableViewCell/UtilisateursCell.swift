//
//  UtilisateursCell.swift
//  fireBase
//
//  Created by Adrien Cortes on 21/03/2021.
//

import UIKit

class UtilisateursCell: UITableViewCell {

    @IBOutlet weak var photo: ImageArrondie!
    @IBOutlet weak var nomLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    var utilisateur: Utilisateur!
    var controller: RechercheController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configuration(utilisateur:Utilisateur,controller:RechercheController){
        self.utilisateur = utilisateur
        self.controller = controller
        self.photo.telecharger(urlString: utilisateur.imageurl)
        self.nomLbl.text = self.utilisateur.prenom + " " + self.utilisateur.nom
        self.messageLbl.text = self.utilisateur.accueil
        //on va mettre à jour les données dans la class utilisateur 
        Donnees().obtenirChangementUtilisateur(id: self.utilisateur.id) { (key, value) -> (Void) in
            if let clef = key, let valeur = value{
                self.utilisateur.miseAjour(cle: clef, valeur: valeur)
                print(valeur)
                controller.tableView.reloadData()
            }
        }
    }
    
}
