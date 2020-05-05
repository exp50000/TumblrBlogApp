//
//  PhotoPostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class PhotoPostCellViewModel: PostCellViewModel {
    
    var postID: Int
    
    var avatar: String = ""
    var name: String = ""
    var photo: String = ""
    var caption: NSAttributedString = NSAttributedString()
    
    var cellHeight: CGFloat = 400
    
    init(post: PostModel, bloger: InfoModel) {
        
        postID = post.id ?? -1
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        photo = post.photos?.first?.alt_sizes?
            .first(where: { $0.width == 500 })?.url ?? ""
        caption = collapsedComment(post.caption ?? "", numberOfLines: 3, width: UIScreen.main.bounds.width - 41) ?? NSAttributedString()
        
        calculateCellHeight(with: UIScreen.main.bounds.width)
    }
}

private extension PhotoPostCellViewModel {
    
    func calculateCellHeight(with width: CGFloat) {
        var height: CGFloat = 78
        
        if !caption.string.isEmpty {
            height += caption.height(with: width - 41) + 13
        }
        
        height += width
        
        cellHeight = height
    }
    
    func collapsedComment(_ string: String, numberOfLines: Int, width: CGFloat) -> NSAttributedString? {
        guard !string.isEmpty else { return nil }
        
        var format = string.htmlToString
        if format.first == "\n" {
            format = String(format.dropFirst())
        }
        
        let mutableString = NSMutableAttributedString(
            string: " ...... more" + format,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                         NSAttributedString.Key.foregroundColor: UIColor(r: 77, g: 91, b: 107)]
        )
        
        var result: (string: String, isCollapse: Bool) = ("", false)
        result = mutableString.string.subStringWithNumberOfLines(numberOfLines, font: UIFont.systemFont(ofSize: 15), width: width)
        
        var commentString = result.string
        if result.isCollapse {
            if result.string.last == "\n" {
                commentString = String(result.string.dropLast())
            }
            
            if let range = mutableString.string.range(of: commentString) {
                mutableString.replaceCharacters(in: NSRange(range.upperBound..., in: mutableString.string), with: "")
            }
            
            mutableString.append(NSAttributedString(
                string: " ...... more",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
                    NSAttributedString.Key.foregroundColor: UIColor(r: 123, g: 146, b: 173)])
            )
        }
        
        mutableString.replaceCharacters(in: NSRange(location: 0, length: 12), with: "")
        
        return mutableString
    }
}


