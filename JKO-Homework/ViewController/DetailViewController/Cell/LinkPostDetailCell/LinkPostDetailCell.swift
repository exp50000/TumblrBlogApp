//
//  LinkPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class LinkPostDetailCell: UITableViewCell {

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
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    @IBOutlet weak var linkImageHeightConstraint: NSLayoutConstraint!
    
    var viewModel: LinkPostDetailCellViewModel?
}


extension LinkPostDetailCell {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? LinkPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        titleLabel.text = viewModel.linkTitle
        
        urlLabel.text = viewModel.linkUrl
        
        descriptionTextView.attributedText = viewModel.description
        descriptionTextView.isHidden = viewModel.description.string.isEmpty
        
        linkImageView.setImage(url: viewModel.linkPhoto)
        
        if viewModel.photoRatio > 0 {
            linkImageHeightConstraint.constant = UIScreen.main.bounds.width / viewModel.photoRatio
        }
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
    }
}
