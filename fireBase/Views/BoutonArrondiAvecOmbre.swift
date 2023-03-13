//
//  BoutonArrondiAvecOmbre.swift
//  fireBase
//
//  Created by Adrien Cortes on 17/03/2021.
//

import UIKit

class BoutonArrondiAvecOmbre: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlaceUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        miseEnPlaceUI()
    }
    func miseEnPlaceUI(){
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.75
    }
    

}
