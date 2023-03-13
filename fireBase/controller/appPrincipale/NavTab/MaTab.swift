//
//  MaTab.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import UIKit

class MaTab: UITabBarController {
    var monId : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    func setup(id:String){
        //Donnees().miseAJourToken(id, UD().getToken()!)
        //on met à jour le token 
        self.monId = id
        let dernier = DerniersMessagesControllers()
        dernier.monId = id
        let dernierNav = UINavigationController(rootViewController: dernier)
        dernierNav.title = "Messages"
        dernierNav.tabBarItem.image = UIImage(named: "messages")
        
        //dernierNav.tabBarItem.badgeColor = .white
        
        
        let recherche = RechercheController()
        recherche.monId = id
        let rechercheNav = UINavigationController(rootViewController: recherche)
        rechercheNav.title = "rechercher"
        rechercheNav.tabBarItem.image = UIImage(named: "recherche")
        
        let profil = Profil()
        profil.monId = id
        let profilNav = UINavigationController(rootViewController: profil)
        profilNav.title = "profil"
        profilNav.tabBarItem.image = UIImage(named: "profil")
        
        viewControllers = [dernierNav,profilNav,rechercheNav]
        tabBar.clipsToBounds = true
        
    }

}
