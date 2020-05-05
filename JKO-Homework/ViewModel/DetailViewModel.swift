//
//  DetailViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class DetailViewModel: NSObject {
    
    var postID: Int
    
    var blogID: String
    
    var cellViewModel: PostDetailCellViewModel?
    
    @objc dynamic var apiStatus: APIStatus = .none
    
    init(blogID: String, postID: Int) {
        
        self.postID = postID
        self.blogID = blogID
        
        super.init()
        
        apiGetPosts()
    }
}

extension DetailViewModel {
    
    func apiGetPosts() {
        apiStatus = .start
        
        BlogManager.GetPosts(blogID, postID: postID) {  response in
            DispatchQueue.main.async {
                self.handleGetPostsReponse(response)
            }
        }
    }
}

extension DetailViewModel {
    
    func handleGetPostsReponse(_ response: PostResponse?) {
        guard
            let response = response,
            let posts = response.posts,
            let bloger = response.blog
        else {
            return apiStatus = .error
        }
        
        guard let post = posts.first else {
            return apiStatus = .empty
        }
        
        cellViewModel = {
            switch post.typeEnum {
            case .text:
                return TextPostDetailCellViewModel(post: post, bloger: bloger)
            case .photo:
                return PhotoPostDetailCellViewModel(post: post, bloger: bloger)
            case .quote:
                return QuotePostDetailCellViewModel(post: post, bloger: bloger)
            case .link:
                return LinkPostDetailCellViewModel(post: post, bloger: bloger)
            case .chat:
//                return ChatPostCellViewModel(post: post, bloger: bloger)
                break
            default:
                return nil
            }
            
            return nil
        }()
        
        apiStatus = .success
    }
}
