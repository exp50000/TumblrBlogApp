//
//  AnswerPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/15.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class AnswerPostDetailCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var askingNameLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    var viewModel: AnswerPostDetailCellViewModel?
}

extension AnswerPostDetailCell: PostDetailCellConfigurable {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? AnswerPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        askingNameLabel.text = viewModel.askingName
        
        questionLabel.text = viewModel.question
        
        answerLabel.text = viewModel.answer
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
    }
}
