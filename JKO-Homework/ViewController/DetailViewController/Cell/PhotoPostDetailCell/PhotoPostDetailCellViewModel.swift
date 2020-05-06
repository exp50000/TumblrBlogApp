//
//  PhotoPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class PhotoPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    var caption: NSAttributedString

    var photo: String = ""
    
    /// 寬高比
    var photoRatio: CGFloat = 0.0
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        
        caption = post.caption?.htmlToAttributedString ?? NSAttributedString()
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
        
        if let _photo = post.photos?.first?.alt_sizes?.first {
            photo = _photo.url ?? ""
            if let height = _photo.height, height > 0 {
                photoRatio =  CGFloat(_photo.width ?? 0) / CGFloat(height)
            }
        }
    }
}
