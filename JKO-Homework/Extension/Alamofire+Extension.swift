//
//  Alamofire+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire


/**
 Creates a request using the shared manager instance for the specified URL request,
 and exec completionHandler on non main thread. (for Data format)
 
 - parameter URLRequest:        The URL request
 - parameter completionHandler: The code to be executed once the request has finished.
 
 - returns: The created request.
 */
@discardableResult
public func requestData(
    _ URLRequest: URLRequestConvertible,
    completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Request {
    
    let queue = DispatchQueue.global()
    let request = AF.request(URLRequest)
    
    request.responseData(queue: queue) { (response) in
        completionHandler(response)
    }
    
    return request
}
