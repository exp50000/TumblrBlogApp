//
//  BlogManager.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire

class BlogManager {
    
    public static func GetInfo(_ blogID: String, completionHandler: @escaping (InfoModel?) -> Void) {
        
        requestData(BlogRouter.info(blogID: blogID)) { response in
            var info: InfoModel?
            defer { completionHandler(info) }
            
            switch response.result {
            case .success(let data):
                guard let response = APIResponse<InfoResponse>.decode(from: data) else {
                    completionHandler(nil)
                    return
                }
                
                completionHandler(response.response?.blog)
                
            case .failure(let error):
                print(error, terminator: "\n")
                completionHandler(nil)
            }
        }
    }
    
    
    /// Retrieve Published Posts
    /// - Parameters:
    ///   - blogID: Any blog identifier See the Overview for more details.
    ///   - offset: Post number to start at
    ///   - before: Returns posts published earlier than a specified Unix timestamp, in seconds.
    ///   - completionHandler: do something after getting the response
    public static func GetPosts(
        _ blogID: String,
        postID: Int? = nil,
        type: PostType? = nil,
        offset: Int? = nil,
        before: Int? = nil,
        completionHandler: @escaping (PostResponse?) -> Void) {
        
        let urlRequest = BlogRouter.posts(
            blogID: blogID,
            postID: postID,
            type: type?.rawValue,
            offset: offset,
            before: before)
        
        requestData(urlRequest) { response in
            var result: PostResponse?
            defer { completionHandler(result) }
            
            switch response.result {
            case .success(let data):
                guard let response = APIResponse<PostResponse>.decode(from: data) else {
                    completionHandler(nil)
                    return
                }
                
                completionHandler(response.response)
                
            case .failure(let error):
                print(error, terminator: "\n")
                completionHandler(nil)
            }
        }
    }
}
