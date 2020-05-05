//
//  UITableViewCell+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/6.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


extension NSObjectProtocol where Self: UITableViewCell {
    
    static var cellIdentifier: String {
        return "\(Self.self)"
    }
}
