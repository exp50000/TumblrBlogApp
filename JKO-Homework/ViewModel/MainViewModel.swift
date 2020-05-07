//
//  MainViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class MainViewModel: NSObject {
    
    var blogID: String {
        return InfoManager.blogID
    }
    
    private(set) var blogerInfo: InfoModel?
    private(set) var infoHeaderCellViewModel: InfoHeaderCellViewModel?
    
//    private(set) var posts: [PostModel] = []
    private(set) var postCellViewModels: [PostCellViewModel] = []
    
    private(set) var totalPosts: Int = 0
    private(set) var lastRequestPostCount = 0
    var hasMoreToFetch: Bool {
        return totalPosts - postCellViewModels.count > 0
    }
    private(set) var before: Int = Int.max
    
    private var isFetching = false
    
    @objc dynamic var apiInfoStatus: APIStatus = .none
    @objc dynamic var apiPostsStatus: APIStatus = .none
    @objc dynamic var apiMorePostsStatus: APIStatus = .none
    
    override init() {
        super.init()
        
        apiGetInfo()
    }
}


extension MainViewModel {
    
    func getInfo() {
        apiGetInfo()
    }
    
    func getPost() {
        apiGetPosts()
    }
    
    func fetchMorePosts() {
        apiGetMorePosts(before: before)
    }
    
}

private extension MainViewModel {
    
    func apiGetInfo() {
        blogerInfo = nil
        infoHeaderCellViewModel = nil
        
        apiInfoStatus = .start
        
        BlogManager.GetInfo(blogID) { response in
            DispatchQueue.main.async {
                self.handleGetInfoReponse(response)
            }
        }
    }
    
    func apiGetPosts() {
//        clearPostData()
        
        apiPostsStatus = .start
        
        BlogManager.GetPosts(blogID) {  response in
            DispatchQueue.main.async {
                self.handleGetPostsReponse(response)
            }
        }
    }
    
    func apiGetMorePosts(before time: Int) {
        guard !isFetching else {
            return
        }
        
        apiMorePostsStatus = .start
        
        isFetching = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            BlogManager.GetPosts(self.blogID, before: time) {  response in
                DispatchQueue.main.async {
                    self.handleGetMorePostsReponse(response)
                }
            }
        }
    }
    
    func clearPostData() {
        postCellViewModels.removeAll()
        totalPosts = 0
        lastRequestPostCount = 0
        before = Int.max
    }
}

private extension MainViewModel {
    
    func handleGetInfoReponse(_ response: InfoModel?) {
        guard let response = response else {
            return apiInfoStatus = .error
        }
        
        if let index = InfoManager.blogerInfos.firstIndex(where: { $0.url == response.url }) {
            InfoManager.blogerInfos.remove(at: index)
        }
        InfoManager.blogerInfos.insert(response, at: 0)
        
        blogerInfo = response
        infoHeaderCellViewModel = InfoHeaderCellViewModel(info: response)
        apiInfoStatus = .success
        
        apiGetPosts()
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
        
        postCellViewModels = posts.compactMap({ post -> PostCellViewModel? in
            switch post.typeEnum {
            case .text:
                return TextPostCellViewModel(post: post, bloger: bloger)
            case .photo:
                return PhotoPostCellViewModel(post: post, bloger: bloger)
            case .quote:
                return QuotePostCellViewModel(post: post, bloger: bloger)
            case .link:
                return LinkPostCellViewModel(post: post, bloger: bloger)
            case .chat:
                return ChatPostCellViewModel(post: post, bloger: bloger)
            default:
                return nil
            }
        })
        
        totalPosts = response.total_posts ?? 0
        lastRequestPostCount = postCellViewModels.count
        if let timestamp = posts.last?.timestamp, timestamp < before {
            before = timestamp
        }
        
        apiPostsStatus = .success
    }
    
    func handleGetMorePostsReponse(_ response: PostResponse?) {
        guard
            let response = response,
            let posts = response.posts,
            let bloger = response.blog
        else {
            return apiMorePostsStatus = .error
        }
        
        guard !posts.isEmpty else {
            return apiMorePostsStatus = .empty
        }
        
        let viewModels = posts.compactMap({ post -> PostCellViewModel? in
            print("===== time \(post.timestamp ?? 0)")
            
            switch post.typeEnum {
            case .text:
                return TextPostCellViewModel(post: post, bloger: bloger)
            case .photo:
                return PhotoPostCellViewModel(post: post, bloger: bloger)
            case .quote:
                return QuotePostCellViewModel(post: post, bloger: bloger)
            case .link:
                return LinkPostCellViewModel(post: post, bloger: bloger)
            case .chat:
                return ChatPostCellViewModel(post: post, bloger: bloger)
            default:
                return TextPostCellViewModel(post: post, bloger: bloger)
            }
        })
        self.postCellViewModels += viewModels
        
        lastRequestPostCount = viewModels.count
        totalPosts = response.total_posts ?? 0
        if let timestamp = posts.last?.timestamp, timestamp < before {
            before = timestamp
        }
        
        isFetching = false
        apiMorePostsStatus = .success
    }
}
