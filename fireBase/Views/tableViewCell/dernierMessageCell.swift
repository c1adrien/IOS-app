//
//  dernierMessageCell.swift
//  fireBase
//
//  Created by Adrien Cortes on 03/04/2021.
//

import UIKit

class dernierMessageCell: UITableViewCell {

    @IBOutlet weak var photoDeProfil: ImageArrondie!
    @IBOutlet weak var prenomLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    var dernier:DernierMessage!
    var controller:DerniersMessagesControllers?
    var monId: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configuration(dernier:DernierMessage,monId: String, controller:DerniersMessagesControllers,idPath: Int){
        self.dernier=dernier
        self.monId = monId
        self.controller = controller
        photoDeProfil.telecharger(urlString: self.dernier.utilisateur.imageurl)
        prenomLbl.text = self.dernier.utilisateur.prenom
        dateLbl.text = self.dernier.date.dateLisiblePourMessage()
        if let message = self.dernier.texte{
            messageLbl.text = message
        }
        Donnees().obtenirChangementDeMessage(from: monId, to: self.dernier.utilisateur.id) { (key, value) in
            if let cle = key, let valeur = value{
                self.dernier.miseAJour(cle: cle, valeur: valeur)
                //controller.derniersMessages[idPath].miseAJour(cle: cle, valeur: valeur)
                //print(idPath)
                //controller.derniersMessages.sort(by: ({$0.date>$1.date}))
                controller.tableView.reloadData()
                
            }
          // controller.reorganiserMaj()
        }
        
        
    }
    
}
