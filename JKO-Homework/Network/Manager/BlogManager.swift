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
}
