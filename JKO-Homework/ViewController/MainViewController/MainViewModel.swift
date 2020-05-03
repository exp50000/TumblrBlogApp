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
    
    @objc dynamic var apiInfoStatus: APIStatus = .none
    
    override init() {
        super.init()
        
        apiGetInfo()
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
}
