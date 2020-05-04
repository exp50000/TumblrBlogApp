//
//  NSAttributedString+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func height(with constrainedWidth: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil)
        
        return ceil(rect.height)
    }
}
