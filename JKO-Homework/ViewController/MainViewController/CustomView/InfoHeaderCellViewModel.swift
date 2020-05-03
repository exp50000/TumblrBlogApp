//
//  InfoHeaderCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class InfoHeaderCellViewModel {
    
    private(set) var title: String = "Untitled"
    private(set) var description: String = ""
    private(set) var avatar: String = ""
    
    var cellHeight: CGFloat = 120
    
    init(info: InfoModel, cellWidth: CGFloat? = UIScreen.main.bounds.width) {
        title = info.title ?? "Untitled"
        description = info.description ?? ""
        avatar = info.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        
        calculateCellHeight(with: cellHeight)
    }
}

private extension InfoHeaderCellViewModel {
    
    func calculateCellHeight(with width: CGFloat) {
        
        let height: CGFloat = 60
        
        let titleHeight = title.height(
            withConstrainedWidth: width - 144,
            font: UIFont.systemFont(ofSize: 32, weight: .medium))
        
        let descriptionHeight = description.height(
            withConstrainedWidth: width - 144,
            font: UIFont.systemFont(ofSize: 17))
        
        cellHeight = height + titleHeight + descriptionHeight
    }
}
