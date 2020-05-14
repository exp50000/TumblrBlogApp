//
//  AnswerPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/14.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class AnswerPostCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var askingNameLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var viewModel: AnswerPostCellViewModel?
}


extension AnswerPostCell: PostCellConfigurable {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? AnswerPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        askingNameLabel.text = viewModel.askingName
        
        questionLabel.text = viewModel.question
    }
}
