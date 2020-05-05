//
//  PhotoPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoPostCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var captionTextView: UITextView! {
        didSet {
            captionTextView.textContainer.lineFragmentPadding = 0
            captionTextView.textContainerInset = UIEdgeInsets(top: 13, left: 18, bottom: 0, right: 23)
        }
    }
    
    var viewModel: PhotoPostCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.clear()
        photoImageView.sd_cancelCurrentImageLoad()
        photoImageView.image = nil
    }
}

extension PhotoPostCell: PostCellConfigurable {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? PhotoPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        photoImageView.setImage(url: viewModel.photo)
        
        captionTextView.attributedText = viewModel.caption
    }
}
