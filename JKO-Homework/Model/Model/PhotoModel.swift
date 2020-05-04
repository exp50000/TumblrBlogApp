//
//  PhotoModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation

class PhotoModel: ModelBase {
    
    /// user supplied caption for the individual photo (Photosets only)
    var caption: String?
    
    /// alternate photo sizes, each with:
    var alt_sizes: [AlternatePhotoSizeModel]?
}
