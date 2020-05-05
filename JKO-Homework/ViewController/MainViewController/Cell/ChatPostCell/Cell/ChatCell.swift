//
//  ChatCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phraseLabel: UILabel!
}

extension ChatCell {
    
    func configure(name: String, phrase: String) {
        nameLabel.text = name
        phraseLabel.text = phrase
    }
}
