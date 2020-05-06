//
//  PostModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class PostModel: ModelBase {
    ///The short name used to uniquely identify a blog
    var blog_name: String?
    
    /// The post's unique ID
    var id: Int?
    
    /// The post's unique ID as a String
    var id_string: String?
    
    /// The location of the post
    var post_url: String?
    
    ///  The type of post
    var type: String?
    
    /// The time of the post, in seconds since the epoch
    var timestamp: Int?
    
    /// The GMT date and time of the post, as a string
    var date: String?
    
    /// The post format: html or markdown
    var format: String?
    
    /// The key used to reblog this post
    var reblog_key: String?
    
    /// Tags applied to the post
    var tags: [String]?
    
    ///Indicates whether the post was created via the Tumblr bookmarklet
    var bookmarklet: Bool?
    
    /// Indicates whether the post was created via mobile/email publishing
    var mobile: Bool?
    
    /// The URL for the source of the content (for quotes, reblogs, etc.)
    var source_url: String?
    
    /// The title of the source site
    var source_title: String?
    
    /// Indicates if a user has already liked a post or not
    var liked: Bool?
    
    ///  Indicates the current state of the post
    var state: String?
    
    var short_url: String?
    
    
    // MARK: - Text Post
    
    /// The optional title of the post
    /// or the title of the page the link points to
    var title: String?
    
    /// The full post body
    var body: String?
    
    
    // MARK: - Photo Post
    
    /// The user-supplied caption
    var caption: String?
    
    /// Photo objects with properties
    var photos: [PhotoModel]?
    
    
    // MARK: - Quote Post
    
    /// The text of the quote (can be modified by the user when posting)
    var text: String?
    
    /// Full HTML for the source of the quote Example: <a href="...">Steve Jobs</a>
    var source: String?
    
    
    // MARK: - Link Post
    
    /// A user-supplied description
    var description: String?
    
    /// The link!
    var url: String?
    
    /// The author of the article the link points to
    var link_author: String?
    
    /// An excerpt from the article the link points to
    var excerpt: String?
    
    /// The publisher of the article the link points to
    var publisher: String?
    
    // MARK: - Chat Post
    
    /// Array of objects with the following properties:
    var dialogue: [DialogueModel]?
}

extension PostModel {
    
    var typeEnum: PostType {
        return PostType(rawValue: type ?? "") ?? .unknown
    }
}
