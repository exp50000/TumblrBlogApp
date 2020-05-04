//
//  AlternatePhotoSizeModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation

class AlternatePhotoSizeModel: ModelBase {
    
    /// width of the photo, in pixels
    var width: Int?
    
    /// height of the photo, in pixels
    var height: Int?
    
    /// Location of the photo file (either a JPG, GIF, or PNG)
    var url: String?
}
