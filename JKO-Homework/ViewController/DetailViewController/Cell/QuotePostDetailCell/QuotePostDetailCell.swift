//
//  QuotePostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class QuotePostDetailCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var sourceView: UIView! {
        didSet {
            sourceView.layer.cornerRadius = 9
            sourceView.clipsToBounds = true
            
            sourceView.layer.borderWidth = 1
            sourceView.layer.borderColor = UIColor(r: 222, g: 226, b: 231).cgColor
        }
    }
    
    @IBOutlet weak var sourceTextView: UITextView! {
        didSet {
            sourceTextView.dataDetectorTypes = .link
            sourceTextView.linkTextAttributes = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.black
            ]
            
            sourceTextView.textContainer.lineFragmentPadding = 0
            sourceTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    @IBOutlet weak var textTextView: UITextView! {
        didSet {
            textTextView.textContainer.lineFragmentPadding = 0
            textTextView.textContainerInset = UIEdgeInsets(top: 13, left: 18, bottom: 0, right: 23)
        }
    }
    
    
    var viewModel: QuotePostDetailCellViewModel?
}

extension QuotePostDetailCell {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? QuotePostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        sourceTextView.attributedText = viewModel.source
        
        textTextView.attributedText = viewModel.text
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
    }
    
}
