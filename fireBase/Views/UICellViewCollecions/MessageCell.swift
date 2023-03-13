//
//  MessageCell.swift
//  fireBase
//
//  Created by Adrien Cortes on 23/03/2021.
//

import UIKit

class MessageCell: UICollectionViewCell {

    @IBOutlet weak var imageProfil: UIImageView!
    
    @IBOutlet weak var bulle: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var imageEnvoyee: UIImageView!
    
    @IBOutlet var bulleDroiteContrainte: NSLayoutConstraint!
    
    @IBOutlet  var bulleGaucheContrainte: NSLayoutConstraint!
    @IBOutlet  var largeurBulleContrainte: NSLayoutConstraint!
    
    
    var message:Messages!
    var monId: String!
    func configurerCell(monId:String, message:Messages,image:UIImage?){
        self.monId = monId
        self.message = message
        //par défault
        imageProfil.image = UIImage(named: "photo_profil")
        bulleGaucheContrainte.isActive = true
        bulleDroiteContrainte.isActive = true
        largeurBulleContrainte.constant = 200 // largeur de base
        imageProfil.isHidden = false
        imageEnvoyee.isHidden = true
        textLbl.isHidden = true
        bulle.layer.cornerRadius = 10 //pour avoir léger arrondi
        
        if self.monId == self.message.from{
            imageProfil.isHidden = true
            bulleGaucheContrainte.isActive = false
            //bulleGaucheContrainte.constant = 48
            bulle.backgroundColor = BULLE_BLEU
            
        }else{
            //bulleDroiteContrainte.constant = 48
            bulleDroiteContrainte.isActive = false
            bulle.backgroundColor = BULLE_VERTE
            imageProfil.image = image
        }
        if let text = self.message.texte {
            textLbl.isHidden = false
            textLbl.text = text
            dateLbl.text = message.date.dateLisiblePourMessage()
            let largeurDeText = text.largeur(hauteur: UIScreen.main.bounds.width - 100, font: UIFont.systemFont(ofSize: 17)) + 32
            if largeurDeText < 75 {
                largeurBulleContrainte.constant = 75
            }else{
                largeurBulleContrainte.constant = largeurDeText
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
