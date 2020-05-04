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
    case posts(blogID: String, type: String?, offset: Int?, before: Int?)
    
    var controllerName: String {
        return "blog"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .info:   return .get
        case .avatar: return .get
        case .posts:  return .get
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
        case .posts(let blogID, let type, _, _):
            var request = "/\(blogID)/posts"
            if let type = type {
                request += "/\(type)"
            }
            return request
        }
    }
    
    var parameters:[String: Any]? {
        switch self {
        case .info:
            return ["api_key": BaseConfig.accessToken]
            
        case .posts(_, _, let offset, let before):
            var parameters: [String: Any] = [
                "api_key": BaseConfig.accessToken,
                "limit": 20
            ]
            
            if let offset = offset {
                parameters["offset"] = offset
            }
            
            if let before = before {
                parameters["before"] = before
            }
            
            return parameters
            
        default:
            return nil
        }
    }
    
    internal func asURLRequest() throws -> URLRequest {
        return try APIRouterHelper.URLRequest(requestRouter: self)
    }
}
