//
//  QuotePostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class QuotePostDetailCellViewModel: PostDetailCellViewModel {
    
    var postID: Int
    
    var avatar: String
    
    var shortUrl: String
    
    var postDate: String
    
    var name: String
    
    var source: NSAttributedString
    
    var text: NSAttributedString
    
    
    init(post: PostModel, bloger: InfoModel) {
        
        postID = post.id ?? -1
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        source = post.source?.htmlToAttributedString ?? NSAttributedString()
        text = post.text?.htmlToAttributedString ?? NSAttributedString()
        
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
    }
}
