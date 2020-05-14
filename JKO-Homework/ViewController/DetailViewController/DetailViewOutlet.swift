//
//  DetailViewOutlet.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class DetailViewOutlet: NSObject {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerTabelViewCell()
        }
    }
    
}


extension DetailViewOutlet {
    
    func registerTabelViewCell() {
        tableView.register(UINib(nibName: "TextPostDetailCell", bundle: nil), forCellReuseIdentifier: TextPostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "PhotoPostDetailCell", bundle: nil), forCellReuseIdentifier: PhotoPostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "QuotePostDetailCell", bundle: nil), forCellReuseIdentifier: QuotePostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "LinkPostDetailCell", bundle: nil), forCellReuseIdentifier: LinkPostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "ChatPostDetailCell", bundle: nil), forCellReuseIdentifier: ChatPostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "VideoPostDetailCell", bundle: nil), forCellReuseIdentifier: VideoPostDetailCell.cellIdentifier)
        tableView.register(UINib(nibName: "AnswerPostDetailCell", bundle: nil), forCellReuseIdentifier: AnswerPostDetailCell.cellIdentifier)
    }
}
