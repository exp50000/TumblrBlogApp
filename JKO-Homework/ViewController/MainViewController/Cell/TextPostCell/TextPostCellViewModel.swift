//
//  TextPostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class TextPostCellViewModel: PostCellViewModel {
    
    private(set) var avatar: String = ""
    private(set) var name: String = ""
    private(set) var title: String = ""
    private(set) var body: NSAttributedString = NSAttributedString()
    
    var cellHeight: CGFloat = 400
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        title = post.title ?? ""
        body = post.body?.htmlToAttributedString ?? NSAttributedString()
        
        calculateCellHeight(with: UIScreen.main.bounds.width)
    }
}

private extension TextPostCellViewModel {
    
    func calculateCellHeight(with width: CGFloat) {
        var height: CGFloat = 86
        
        height += title.height(
            with: width - 35,
            font: UIFont.systemFont(ofSize: 20, weight: .bold))
        
        height += body.height(
            with: width - 35)
        
        
        cellHeight = height > 400 ? 400 : height
    }
}
