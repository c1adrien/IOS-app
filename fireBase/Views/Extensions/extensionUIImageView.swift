//
//  extensionUIImageView.swift
//  fireBase
//
//  Created by Adrien Cortes on 21/03/2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView{
    func telecharger(urlString:String?){
        image = UIImage(named: "photo_profil")
        guard let string = urlString else{return} //si c'est nil on garde super man
        guard let url = URL(string: string) else{return}//on voit si l'url est convertible
        sd_setImage(with: url, completed: nil)
    }
}
