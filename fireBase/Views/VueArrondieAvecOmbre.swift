//
//  VueArrondieAvecOmbre.swift
//  fireBase
//
//  Created by Adrien Cortes on 17/03/2021.
//

import UIKit

class VueArrondieAvecOmbre: UIView {

    //pour storyboard et XIB
    override required init?(coder: NSCoder) {
        super.init(coder:coder)
        miseEnPlaceUI()
    }
    //programmatique
    override init(frame: CGRect) {
        super.init(frame:frame)
        miseEnPlaceUI()
    }
    
    func miseEnPlaceUI(){
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0.75
    }

}
