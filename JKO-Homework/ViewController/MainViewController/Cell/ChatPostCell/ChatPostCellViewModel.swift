//
//  ChatPostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class ChatPostCellViewModel: PostCellViewModel {
    var postID: Int
    
    var avatar: String = ""
    var name: String = ""
    var dialogues: [(name: String, phrase: String)] = []
    
    var cellHeight: CGFloat = 300
    
    init(post: PostModel, bloger: InfoModel) {
        
        postID = post.id ?? -1
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        
        dialogues = post.dialogue?.compactMap({
            return ($0.name ?? "", $0.phrase ?? "")
        }) ?? []
        
//        calculateCellHeight(with: UIScreen.main.bounds.width)
    }
}

extension ChatPostCellViewModel {
    
    func calculateCellHeight(with width: CGFloat) {
        
    }
}
