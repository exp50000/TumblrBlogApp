//
//  TextPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class TextPostDetailCell: UITableViewCell {
    
    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    var viewModel: TextPostDetailCellViewModel?
}

extension TextPostDetailCell {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? TextPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        titleTextView.text = viewModel.title
        bodyTextView.attributedText = viewModel.body
        
        titleTextView.isHidden = titleTextView.text.isEmpty
        bodyTextView.isHidden = bodyTextView.text.isEmpty
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
    }
}
