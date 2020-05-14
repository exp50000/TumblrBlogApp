//
//  VideoPostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/8.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class VideoPostCellViewModel: PostCellViewModel {
    
    var postID: Int = -1
    
    var cellHeight: CGFloat = 400
    
    var avatar: String = ""
    
    var name: String = ""
    
    var caption: NSAttributedString = NSAttributedString()
    
    var video: String = ""
    
    init(post: PostModel, bloger: InfoModel) {
        
        postID = post.id ?? -1
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        
        
        caption = collapsedComment(post.caption ?? "", numberOfLines: 3, width: UIScreen.main.bounds.width - 41) ?? NSAttributedString()
        if var html = post.player?.last?.embed_code {
            
            let start = html.index(html.startIndex, offsetBy: 0)
            let end = html.index(html.startIndex, offsetBy: 7)
            html.replaceSubrange(start..<end, with: "<video autoplay loop playsinline")
            html = html.replacingOccurrences(of: "</object>", with: "</video>")
            video = html
        }
        
        
        
        calculateCellHeight(with: UIScreen.main.bounds.width)
    }
}

private extension VideoPostCellViewModel {
    
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
