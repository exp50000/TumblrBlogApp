//
//  PostDetailViewModel.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


protocol PostDetailCellViewModel {
    var avatar: String { get set }
    var name: String { get set }
    var shortUrl: String { get set }
}
