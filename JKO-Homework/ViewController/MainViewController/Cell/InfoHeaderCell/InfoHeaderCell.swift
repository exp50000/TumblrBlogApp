//
//  InfoHeaderCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/1.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage

class InfoHeaderCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private(set) var viewModel: InfoHeaderCellViewModel!
}

extension InfoHeaderCell {
    
    func configure(viewModel: InfoHeaderCellViewModel) {
        
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        avatarImageView.sd_setImage(with: URL(string: viewModel.avatar))
        
        infoViewHeightConstraint.constant = viewModel.cellHeight
        
        indicator.startAnimating()
    }
}
