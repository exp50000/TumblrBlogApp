//
//  ModelBase.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


protocol ModelBase: class, Codable { }

extension ModelBase {
    
    static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            let error = error as NSError
            print("Decode Error: \(error)")
            return nil
        }
    }
    
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
