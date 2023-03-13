//
//  Doubleextension.swift
//  fireBase
//
//  Created by Adrien Cortes on 23/03/2021.
//

import Foundation
import UIKit

extension Double{
    func dateLisiblePourMessage()->String{
        var string = "le"
        var date: Date = Date(timeIntervalSince1970: self)
        let calendrier = Calendar.current
        let formatter = DateFormatter()
        
        if calendrier.isDateInToday(date){
            string = ""
            formatter.timeStyle = .short
        }else if calendrier.isDateInYesterday(date){
            string = "hier : "
            formatter.timeStyle = .short
        }
        else{
            formatter.dateStyle = .short
        }
        let dateString = formatter.string(from: date)
        return string + dateString
    }
}
