//
//  LinkPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage

class LinkPostCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var linkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.textContainer.lineFragmentPadding = 0
            descriptionTextView.textContainerInset = UIEdgeInsets(top: 13, left: 18, bottom: 0, right: 23)
        }
    }
    
    var viewModel: LinkPostCellViewModel?
}


extension LinkPostCell: PostCellConfigurable {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? LinkPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        titleLabel.text = viewModel.linkTitle
        
        urlLabel.text = viewModel.linkUrl
        
        descriptionTextView.attributedText = viewModel.description
        
        linkImageView.setImage(url: viewModel.linkPhoto)
    }
}
