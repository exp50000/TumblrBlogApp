//
//  VideoPostDetailCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/14.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation



class VideoPostDetailCellViewModel: PostDetailCellViewModel {
    
    var avatar: String
    
    var name: String
    
    var shortUrl: String
    
    var postDate: String
    
    var caption: NSAttributedString = NSAttributedString()
    
    var video: String = ""
    
    var videoWidth: Int = 0
    
    
    init(post: PostModel, bloger: InfoModel) {
        
        avatar = bloger.avatar?
            .sorted(by: { $0.width ?? 0 < $1.width ?? 0 })
            .first?.url ?? ""
        name = bloger.name ?? ""
        shortUrl = post.short_url ?? ""
        postDate = post.date?.toLocalDateString() ?? ""
        
        caption = post.caption?.htmlToAttributedString ?? NSAttributedString()
        
        if let player = post.player?.last {
            
            if var html = player.embed_code {
                let start = html.index(html.startIndex, offsetBy: 0)
                let end = html.index(html.startIndex, offsetBy: 7)
                html.replaceSubrange(start..<end, with: "<video autoplay loop playsinline")
                html = html.replacingOccurrences(of: "</object>", with: "</video>")
                video = html
            }
            
            if let width = player.width {
               videoWidth = width
            }
        }
        
        
    }
}
