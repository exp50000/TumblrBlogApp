//
//  LinkPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class LinkPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    var linkTitle: String
    
    var linkUrl: String
    
    var description: NSAttributedString
    
    var linkPhoto: String = ""
    
    var photoRatio: CGFloat = 0
    
       
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        linkTitle = post.title ?? ""
        linkUrl = post.url ?? ""
        description = post.description?.htmlToAttributedString ?? NSAttributedString()
        
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
        
        if let photo = post.photos?.first?.original_size {
            linkPhoto = photo.url ?? ""
            
            if photo.height != 0 {
                photoRatio = CGFloat(photo.width ?? 0) / CGFloat(photo.height ?? 0)
            }
        }
    }
}
