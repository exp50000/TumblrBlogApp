//
//  APIRouterHelper.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire


protocol RequestRoutable {
    var controllerName: String { get }
    var request: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

class APIRouterHelper {
    fileprivate static func encodingWithMethod(_ method: Alamofire.HTTPMethod) -> ParameterEncoding {
        if method == .post || method == .put {
            return JSONEncoding.default
        }
        
        return URLEncoding.default
    }
    
    static func composeURL(_ requestRouter: RequestRoutable) -> URL {
        let URL = Foundation.URL(
            string: "\(BaseConfig.domainURL)" +
                    "\(requestRouter.controllerName)" +
                    "\(requestRouter.request)")!
        return URL
    }
    
    
    /// 由 Router 轉為 URLRequest
    static func URLRequest(requestRouter: RequestRoutable) throws -> URLRequest {
        let url = composeURL(requestRouter)
        let mutableURLRequest = NSMutableURLRequest(url: url)
        
        //設定 HTTP method
        mutableURLRequest.httpMethod = requestRouter.method.rawValue
        
        let parameterEncoding = encodingWithMethod(requestRouter.method)
        return try parameterEncoding.encode(mutableURLRequest as URLRequest, with: requestRouter.parameters)
    }
}
