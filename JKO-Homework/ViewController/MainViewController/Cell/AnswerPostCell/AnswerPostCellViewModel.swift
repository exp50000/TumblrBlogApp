//
//  AnswerPostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/14.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class AnswerPostCellViewModel: PostCellViewModel {
    
    var postID: Int
    
    var cellHeight: CGFloat = 400
    
    var avatar: String
    
    var name: String
    
    var askingName: String
    
    var question: String
    
    init(post: PostModel, bloger: InfoModel) {
        
        postID = post.id ?? -1
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        askingName = (post.asking_name ?? "") + " ask:"
        question = post.question ?? ""
        
        calculateCellHeight(with: UIScreen.main.bounds.width)
    }
}

extension AnswerPostCellViewModel {
    
    func calculateCellHeight(with width: CGFloat) {
        var height: CGFloat = 96
        
        height += askingName.height(
            with: width - 60,
            font: UIFont.systemFont(ofSize: 17, weight: .semibold)) + 5
        
        height += question.height(
            with: width - 100,
            font: UIFont.systemFont(ofSize: 20, weight: .light)) + 30
    
        cellHeight = height
    }
}
