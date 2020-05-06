//
//  ResponseBase.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


protocol ResponseBase: ModelBase {
    associatedtype T
    var meta: MetaModel? { set get }
    var response: T? { set get }
}

class MetaModel: ModelBase {
    var status: Int?
    var msg: String?
}

class APIResponse<T: ModelBase>: ResponseBase {
    var meta: MetaModel?
    var response: T?
}
