//
//  PhotoPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class PhotoPostDetailCell: UITableViewCell {

    
    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: PhotoPostDetailCellViewModel?
}

extension PhotoPostDetailCell: PostDetailCellConfigurable {
    
    func configure(viewModel: PostDetailCellViewModel) {
        
        guard let viewModel = viewModel as? PhotoPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)

        photoImageView.setImage(url: viewModel.photo)
        captionTextView.attributedText = viewModel.caption

        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
        
        photoImageViewHeightConstraint.constant = UIScreen.main.bounds.width / viewModel.photoRatio
    }
}
