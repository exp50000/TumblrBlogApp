//
//  BlogerView.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage


@IBDesignable
class BlogerView: UIView, NibLoadable {
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.borderWidth = 1
            avatarImageView.layer.borderColor = UIColor(r: 222, g: 226, b: 231).cgColor
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupXib()
    }
    
}

extension BlogerView {
    
    func setupView(name: String, avatar: String) {
        avatarImageView.sd_setImage(with: URL(string: avatar))
        nameLabel.text = name
    }
}
