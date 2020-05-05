//
//  PostCellViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/4.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


protocol PostCellViewModel {
    
    var postID: Int { get set }
    
    var cellHeight: CGFloat { get set }
}
