//
//  Copyright (c) 2018年 shinren.pan@gmail.com All rights reserved.
//

import UIKit

extension NSObjectProtocol where Self: UIView
{
    static func FromNib(_ name: String? = nil, index: Int = 0) -> Self
    {
        let name_ = name ?? "\(Self.self)"
        let nib = UINib(nibName: name_, bundle: nil)
        
        guard let result = nib.instantiate(withOwner: nil, options: nil)[index] as? Self
        else
        {
            fatalError()
        }
        
        return result
    }
}
