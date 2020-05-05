//
//  UIViewController+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


extension NSObjectProtocol where Self: UIViewController
{
    static func FromStoryboard(_ name: String? = nil, Id: String? = nil) -> Self
    {
        let name_ = name ?? "\(Self.self)"
        let Id_ = Id ?? "\(Self.self)"
        
        guard
            let result = UIStoryboard(name: name_, bundle: nil)
                .instantiateViewController(withIdentifier: Id_) as? Self
        else
        {
            fatalError()
        }
        
        return result
    }
}
