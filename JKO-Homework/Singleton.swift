//
//  Singleton.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class UserDefaultsKey {
    
    static let blogID = "BlogID"
    static let blogerInfos = "BlogerInfos"
}

class InfoManager {
    
    private static var _blogID: String = ""
    static var blogID: String {
        
        get {
            if _blogID.isEmpty {
                _blogID = UserDefaults.standard.string(forKey: UserDefaultsKey.blogID) ?? "pusheen.tumblr.com"
            }
            
            return _blogID
        }
        
        set {
            _blogID = newValue
            UserDefaults.standard.set(_blogID, forKey: UserDefaultsKey.blogID)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    fileprivate static var _blogerInfos: [InfoModel] = []
    public static var blogerInfos: [InfoModel] {
        get {
            if _blogerInfos.isEmpty {
                if let data = UserDefaults.standard.data(forKey: UserDefaultsKey.blogerInfos) {
                    if let blogerInfos = try? JSONDecoder().decode([InfoModel].self, from: data) {
                        _blogerInfos = blogerInfos
                    }
                }
            }
            return _blogerInfos
        }
        
        set {
            _blogerInfos = newValue
            
            if let data = try? JSONEncoder().encode(_blogerInfos) {
                UserDefaults.standard.set(data, forKey: UserDefaultsKey.blogerInfos)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
