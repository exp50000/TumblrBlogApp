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
        image = nil
        switch ImageType.imageTypeFactory(fileName: url) {
        case .gif:
            clear()
            setGifFromURL(URL(string: url)!, loopCount: -1)
        default:
            SwiftyGifManager.defaultManager.deleteImageView(self)
            sd_setImage(with: URL(string: url))
        }
    }
}
