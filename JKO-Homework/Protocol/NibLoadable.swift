//
//  NibLoadable.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


protocol NibLoadable where Self: UIView {
    func setupXib() -> UIView
}

extension NibLoadable {
    
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        return UINib(nibName: String(describing: type(of: self)), bundle: bundle).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    @discardableResult
    func setupXib() -> UIView {
        let contentView = loadViewFromNib()
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return contentView
    }
}
