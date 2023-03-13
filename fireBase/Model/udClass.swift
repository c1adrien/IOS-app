//
//  udClass.swift
//  fireBase
//
//  Created by Adrien Cortes on 24/03/2021.
//

import Foundation
class UD{
    
    let def = UserDefaults.standard
    func setToken(_ string: String){
        def.set(string,forKey: "token")
    }
    
    func getToken()->String?{
        return def.string(forKey: "token")
    }
    
}
