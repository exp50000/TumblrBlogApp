//
//  PostResponse.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class PostResponse: ModelBase {
    var blog: InfoModel?
    var posts: [PostModel]?
    
    /// The total number of post available for this request, useful for paginating through results
    var total_posts: Int?
}
