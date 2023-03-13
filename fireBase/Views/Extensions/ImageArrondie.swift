//
//  ImageArrondie.swift
//  fireBase
//
//  Created by Adrien Cortes on 21/03/2021.
//

import UIKit

class ImageArrondie: UIImageView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        arrondirImage()
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        arrondirImage()
    }
    
    func arrondirImage(){
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
        contentMode = .scaleAspectFit
        

    }


}
