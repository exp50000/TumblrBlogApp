//
//  ShortUrlView.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

@IBDesignable
class ShortUrlView: UIView, NibLoadable {

    @IBOutlet weak var urlTextView: UITextView! {
        didSet {
            urlTextView.isEditable = false
            urlTextView.textContainerInset = .zero
            urlTextView.textContainer.lineFragmentPadding = 0
            urlTextView.dataDetectorTypes = .link
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
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

extension ShortUrlView {
    
    func setupView(url: String, date: String) {
        dateLabel.text = "發布時間 " + date
        urlTextView.text = "原文縮網址《\(url)》"
    }
}
