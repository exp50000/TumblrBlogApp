//
//  SwitchBlogerViewController.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class BlogerCell: UITableViewCell {
    @IBOutlet weak var blogerView: BlogerView!
    
    func configure(name: String, avatar: String) {
        blogerView.setupView(name: name, avatar: avatar)
    }
}

class SwitchBlogerViewController: BaseViewController {

    @IBOutlet weak var viewOutlet: SwitchBlogerViewOutlet!
    var blogers = InfoManager.blogerInfos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension SwitchBlogerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BlogerCell
        
        let info = blogers[indexPath.row]
        cell.configure(name: info.name ?? "", avatar: info.avatar?.last?.url ?? "")
        
        return cell
    }
}

extension SwitchBlogerViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        InfoManager.blogID = searchBar.text ?? ""
        
        NotificationCenter.default.post(
            name: Notification.Name("BlogChanged"),
            object: nil)
        
        dismiss(animated: true)
    }
}
