//
//  DerniersMessagesControllers.swift
//  fireBase
//
//  Created by Adrien Cortes on 20/03/2021.
//

import UIKit

class DerniersMessagesControllers: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var monId : String!
    var derniersMessages = [DernierMessage]()
    let cellId = "DernierMessageCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        title="derniers messages"
        observe()
        let nib = UINib(nibName: "dernierMessageCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()

    }
    
    func observe(){
        Donnees().dernierMessage(id: monId) { (dernier) in
            if let dernierMessage = dernier, !self.derniersMessages.contains(where: {$0.utilisateur.id == dernierMessage.utilisateur.id}){
                self.derniersMessages.append(dernierMessage)
                self.reorganiserMaj()
            }
        }
    }
    func reorganiserMaj(){
        derniersMessages = derniersMessages.sorted(by: {$0.date>$1.date})
        //trierMessages()
        //print(derniersMessages[0].utilisateur.prenom)
        tableView.reloadData()
    }
    
    func trierMessages(){
        derniersMessages = derniersMessages.sorted(by: {$0.date>$1.date})
        DispatchQueue.main.async {
            
            //afficher par le bas
            let indexPath = IndexPath(row: self.derniersMessages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.tableView.reloadData()
        }
    }


}

extension DerniersMessagesControllers: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return derniersMessages.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! dernierMessageCell
        cell.configuration(dernier: derniersMessages[indexPath.row],monId: monId, controller: self,idPath: indexPath.row)
        return cell
    
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! dernierMessageCell
        let controller = ChatController()
        
        controller.miseEnPlace(id: monId, utilisateur: derniersMessages[indexPath.row].utilisateur, image: cell.photoDeProfil.image)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
