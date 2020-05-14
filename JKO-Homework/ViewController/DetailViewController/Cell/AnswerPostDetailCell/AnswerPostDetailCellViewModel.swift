//
//  AnswerPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/15.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class AnswerPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    var askingName: String
    
    var question: String
    
    var answer: String
    
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
        
        askingName = post.asking_name ?? ""
        
        question = post.question ?? ""
        
        answer = post.answer?.htmlToString ?? ""
    }
}
