//
//  Messages.swift
//  fireBase
//
//  Created by Adrien Cortes on 23/03/2021.
//

import Foundation
class Messages{
    private var _id:String!
    private var _from:String!
    private var _to:String!
    private var _date:Double!
    private var _texte:String? //on a laissé une image donc pas forcément de texte
    
    private var _imageUrl:String?
    private var _hauteur:Double? //hauteur de l'image éventuelle ?
    private var _largeur:Double? // largeur
    
    //accesseurs
    var from:String{
        return _from
    }
    var to:String{
        return _to
    }
    var date:Double{
        return _date
    }
    var texte:String?{
        return _texte
    }
    var imageUrl:String?{
        return _imageUrl
    }
    var hauteur:Double?{
        return _hauteur
    }
    var largeur:Double?{
        return _hauteur
    }
    
    init(id:String, from:String,to:String,date:Double,texte:String?,imageUrl:String?,hauteur:Double?,largeur:Double?){
        self._id = id
        self._from = from
        self._to = to
        self._date = date
        self._texte = texte
        self._imageUrl = imageUrl
        self._largeur = largeur
        self._hauteur = hauteur
    }
}
