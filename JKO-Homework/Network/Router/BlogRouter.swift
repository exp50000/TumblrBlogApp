//
//  BlogRouter.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire

enum BlogRouter: URLRequestConvertible, RequestRoutable {
    case info(blogID: String)
    case avatar(blogID: String, size: Int?)
    
    var controllerName: String {
        return "blog"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .info: return .get
        case .avatar: return .get
        }
    }
    
    var request: String {
        switch self {
        case .info(let blogID):
            return "/\(blogID)/info"
        case .avatar(let blogID, let size):
            var request = "/\(blogID)/avatar"
            if let size = size {
                request += "/\(size)"
            }
            return request
        }
    }
    
    var parameters:[String: Any]? {
        switch self {
        case .info:
            return ["api_key": BaseConfig.accessToken]
        default:
            return nil
        }
    }
    
    internal func asURLRequest() throws -> URLRequest {
        return try APIRouterHelper.URLRequest(requestRouter: self)
    }
}
