//
//  extensionUIView.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import Foundation
import UIKit


extension UIView{
    
    
    func createActivity(){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.tag = 5
        addSubview(blur)
        
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = self.center
        activity.tag = 6
        activity.color = .darkGray
        activity.startAnimating()
        addSubview(activity)
    }
    func supprimerActivity(){
        for view in subviews{
            if view.tag == 5{
                view.removeFromSuperview()
            }
            if view.tag == 6, let act = view as? UIActivityIndicatorView{
                act.stopAnimating()
                act.removeFromSuperview()
            }
        }
        
    }
}
