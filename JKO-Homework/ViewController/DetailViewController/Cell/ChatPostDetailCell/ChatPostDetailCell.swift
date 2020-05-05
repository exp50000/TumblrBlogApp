//
//  ChatPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class ChatPostDetailCell: UITableViewCell {
    
    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = UITableView.automaticDimension
            
            tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "Cell")
        }
    }
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    var viewModel: ChatPostDetailCellViewModel?
}

extension ChatPostDetailCell {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? ChatPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
        
        tableView.reloadData()
    }
}


extension ChatPostDetailCell: UITableViewDataSource {
    
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
