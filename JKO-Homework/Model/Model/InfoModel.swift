//
//  InfoModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation

class InfoModel: ModelBase {
    var title: String?
    var posts: Int?
    var name: String?
    var updated: Int?
    var description: String?
    var ask: Bool?
    var ask_anon: Bool?
    var likes: Int?
    var is_blocked_from_primary: Bool?
    var avatar: [InfoAvatarModel]?
    var timezone: String?
    var timezone_offset: String?
}
