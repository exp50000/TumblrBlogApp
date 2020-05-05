//
//  ChatPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class ChatPostCell: UITableViewCell {
    
    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 70
            
            tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "Cell")
        }
    }
    
    @IBOutlet weak var readMoreView: UIView!
    
    var viewModel: ChatPostCellViewModel?
}

extension ChatPostCell {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? ChatPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        tableView.reloadData()
    }
}


extension ChatPostCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dialogues.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatCell
        
        if let dialogue = viewModel?.dialogues[indexPath.row] {
            cell.configure(name: dialogue.name, phrase: dialogue.phrase)
        }
        
        return cell
    }
}
