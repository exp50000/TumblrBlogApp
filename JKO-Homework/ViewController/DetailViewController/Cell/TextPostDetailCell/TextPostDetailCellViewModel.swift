//
//  TextPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class TextPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    private(set) var title: String = ""
    
    private(set) var body: NSAttributedString = NSAttributedString()
    
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
        title = post.title ?? ""
        body = post.body?.htmlToAttributedString ?? NSAttributedString()
    }
    
}
