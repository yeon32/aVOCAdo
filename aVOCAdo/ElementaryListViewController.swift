//
//  ElementaryListViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/06/06.
//

import UIKit
import FirebaseDatabase

class ElementaryListViewController : UITableViewController {
    var ref: DatabaseReference!      //Firebase Realtime Database
    
    var aVOCAdo: [Voca] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "ElementaryListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ElementaryListCell")
        
        ref = Database.database().reference()
        
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let elementaryData = try JSONDecoder().decode([String: Elementary].self, from: jsonData)
                let elementaryList = Array(elementaryData.values)
                /*
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }*/
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aVOCAdo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementaryListCell", for: indexPath) as? ElementaryListCell else { return UITableViewCell() }
        
        cell.wordLabel.text = "\(aVOCAdo[indexPath.row].word)"
        cell.meaningLabel.text = "\(aVOCAdo[indexPath.row].meaning)"
        
        return cell
    }
}
