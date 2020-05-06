//
//  ChatPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class ChatPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    var dialogues: [(name: String, phrase: String)] = []
    
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        
        dialogues = post.dialogue?.compactMap({
            return ($0.name ?? "", $0.phrase ?? "")
        }) ?? []
        
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
    }
}
