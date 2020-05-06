//
//  Enums.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


/// Call api 時的狀態.
@objc enum APIStatus: Int {
    case none
    case start
    case success
    case error
    case empty
}

enum PostType: String {
    case unknown
    case text =  "text"
    case photo = "photo"
    case quote = "quote"
    case link =  "link"
    case chat =  "chat"
}

enum ImageType {
    case notSupport
    case jpeg
    case png
    case gif
    case tiff
    
    static func imageTypeFactory(fileName: String) -> ImageType {
        if let extaension = URL(string: fileName.lowercased())?.pathExtension {
            switch extaension {
            case "jpg":
                fallthrough
            case "jpeg":
                return .jpeg
            case "png":
                return .png
            case "gif":
                return .gif
            case "tiff":
                return .tiff
            default:
                break
            }
        }

        return .notSupport
    }
    
    func contentType() -> String {
        switch self {
        case .jpeg:
            return "image/jpeg"
        case .png:
            return "image/png"
        case .gif:
            return "image/gif"
        case .tiff:
            return "image/tiff"
        default:
            return ""
        }
    }
    
    func fileExtension() -> String {
        switch self {
        case .jpeg:
            return ".jpeg"
        case .png:
            return ".png"
        case .gif:
            return ".gif"
        case .tiff:
            return ".tiff"
        default:
            return ""
        }
    }
}
