//
//  UIImageView+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage


extension UIImageView {
    
    func setImage(url: String) {
        switch ImageType.imageTypeFactory(fileName: url) {
        case .gif:
            setGifFromURL(URL(string: url)!, loopCount: -1)
        default:
            sd_setImage(with: URL(string: url))
        }
    }
}
