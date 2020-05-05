//
//  String+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

extension String {
    
    func height(with constrainedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)

        return ceil(rect.height)
    }
}

// MARK: - HTML
extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    
    func subStringWithNumberOfLines(_ limitedNumberOfLines: Int, font: UIFont, width: CGFloat) -> (String, Bool) {
           if self.isEmpty {
               return ("", false)
           }
           
           return self.subStringWithNumberOfLines(limitedNumberOfLines, font: font, size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
       }
       
    func subStringWithNumberOfLines(_ limitedNumberOfLines: Int, font: UIFont, size: CGSize) -> (String, Bool) {
        let textStorage = NSTextStorage(string: self, attributes: [NSAttributedString.Key.font: font])
        
        let textContainer = NSTextContainer(size: size)
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0
        
        let layoutManager = NSLayoutManager()
        layoutManager.textStorage = textStorage
        layoutManager.addTextContainer(textContainer)
        
        var numberOfLines = 0
        var lineRange = NSMakeRange(0, 0)
        var toIndex = 0
        
        while numberOfLines < limitedNumberOfLines  {
            if toIndex >= layoutManager.numberOfGlyphs {
                break
            }
            
            layoutManager.lineFragmentRect(forGlyphAt: toIndex, effectiveRange: &lineRange)
            toIndex = NSMaxRange(lineRange)
            
            numberOfLines += 1
        }
        
        return ((self as NSString).substring(to: toIndex), toIndex != layoutManager.numberOfGlyphs)
    }
}
