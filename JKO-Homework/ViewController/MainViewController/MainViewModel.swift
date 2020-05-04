//
//  MainViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class MainViewModel: NSObject {
    
    var blogID: String = "pusheen.tumblr.com"
    
    var blogerInfo: InfoModel?
    var infoHeaderCellViewModel: InfoHeaderCellViewModel?
    
    var posts: [PostModel] = []
    var postCellViewModels: [PostCellViewModel] = []
    
    @objc dynamic var apiInfoStatus: APIStatus = .none
    
    @objc dynamic var apiPostsStatus: APIStatus = .none
    
    override init() {
        super.init()
        
        apiGetInfo()
        apiGetPosts()
    }
}

private extension MainViewModel {
    
    func apiGetInfo() {
        apiInfoStatus = .start
        
        BlogManager.GetInfo(blogID) { response in
            DispatchQueue.main.async {
                self.handleGetInfoReponse(response)
            }
        }
    }
    
    func apiGetPosts() {
        apiPostsStatus = .start
        
        BlogManager.GetPosts(blogID, type: .photo) {  response in
            DispatchQueue.main.async {
                self.handleGetPostsReponse(response)
            }
        }
    }
}

private extension MainViewModel {
    
    func handleGetInfoReponse(_ response: InfoModel?) {
        guard let response = response else {
            return apiInfoStatus = .error
        }
        
        blogerInfo = response
        infoHeaderCellViewModel = InfoHeaderCellViewModel(info: response)
        apiInfoStatus = .success
    }
    
    func handleGetPostsReponse(_ response: PostResponse?) {
        guard
            let response = response,
            let posts = response.posts,
            let bloger = response.blog
        else {
            return apiPostsStatus = .error
        }
        
        guard !posts.isEmpty else {
            return apiPostsStatus = .empty
        }
        
        self.posts = posts
        postCellViewModels = posts.compactMap({ post -> PostCellViewModel? in
            switch post.typeEnum {
            case .text:
                return TextPostCellViewModel(post: post, bloger: bloger)
            case .photo:
                return PhotoPostCellViewModel(post: post, bloger: bloger)
            default:
                return nil
            }
        })
        apiPostsStatus = .success
    }
}
