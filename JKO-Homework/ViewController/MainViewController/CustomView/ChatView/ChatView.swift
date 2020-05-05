//
//  ChatView.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phraseLabel: UILabel!
    
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
}

extension ChatView {
    
    func configure(name: String, phrase: String) {
        nameLabel.text = name
        phraseLabel.text = phrase
        
        
    }
}

extension ChatView {
    
    func calculateHeight() {
        
    }
}
