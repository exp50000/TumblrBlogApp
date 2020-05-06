//
//  TextPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class TextPostCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var readMoreView: UIView!
    
    var viewModel: TextPostCellViewModel?
}

extension TextPostCell: PostCellConfigurable {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? TextPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        titleTextView.text = viewModel.title
        bodyTextView.attributedText = viewModel.body
        
        titleTextView.isHidden = titleTextView.text.isEmpty
        bodyTextView.isHidden = bodyTextView.text.isEmpty
        
        readMoreView.isHidden = viewModel.cellHeight < 400
    }
}
