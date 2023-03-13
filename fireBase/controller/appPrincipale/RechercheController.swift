//
//  RechercheController.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import UIKit

class RechercheController: UIViewController {
    var monId : String!
    var utilisateurs = [Utilisateur]()
    var utilisateursFiltres = [Utilisateur]()
    var enRecherche = false
    
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        tableView.delegate=self
        tableView.dataSource=self
        tableView.tableFooterView = UIView()
        //bien mettre le nib avec nibName: nom de la class de la cellule
        let nib = UINib(nibName: "UtilisateursCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Utilisateur_cell")
        observer()
        // Do any additional setup after loading the view.
    }
    
    func observer(){
        Donnees().obtenirTous(id: monId) { (Utilisateur) -> (Void) in
            if let user=Utilisateur{
                
                self.utilisateurs.append(user)
                self.tableView.reloadData()
            }
        }
    }


    

}

extension RechercheController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if enRecherche{
            return utilisateursFiltres.count
        }
        else{
            return utilisateurs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Utilisateur_cell") as? UtilisateursCell {
            if enRecherche{
                cell.configuration(utilisateur: utilisateursFiltres[indexPath.row],controller: self)
            }
            else{
                cell.configuration(utilisateur: utilisateurs[indexPath.row],controller: self)
            }
          
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on récupère la cell
        let cell = tableView.cellForRow(at: indexPath) as! UtilisateursCell
        let controller = ChatController()
        if enRecherche{
            controller.miseEnPlace(id: monId, utilisateur: utilisateursFiltres[indexPath.row],image: cell.photo.image)
            
        }
        else{
            controller.miseEnPlace(id: monId, utilisateur: utilisateurs[indexPath.row],image:cell.photo.image )
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


extension RechercheController: UISearchBarDelegate{
    //quand on appuie sur recherche on vire le clavier
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if search.text == nil || search.text == ""{
            enRecherche = false
            view.endEditing(true)
        }
        else{
            enRecherche = true
            let minuscule = search.text!.lowercased() //on récupère le texte min
            utilisateursFiltres = utilisateurs.filter{
                //on retourne tous les utilisateurs dont le nom contient les minuscules ci-dessous
                return $0.nom.lowercased().range(of: minuscule) != nil || $0.prenom.lowercased().range(of: minuscule) != nil
            }
        }
        tableView.reloadData()
    }
    
}
