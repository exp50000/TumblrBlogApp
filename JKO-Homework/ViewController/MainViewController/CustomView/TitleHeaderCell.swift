//
//  TitleHeaderCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/1.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class TitleHeaderCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshIndicatorHeightConstraint: NSLayoutConstraint!
}

extension TitleHeaderCell {
    
    func updateRefreshIndicatorHeight(_ constant: CGFloat) {
        refreshIndicatorHeightConstraint.constant = constant
    }
    
    func configure() {
        indicator.startAnimating()
    }
}
