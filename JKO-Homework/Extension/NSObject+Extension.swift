//
//  NSObject+Extension.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/3.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation

public struct AssociatedKey
{
    static var ChangeListener: String = "ChangeListener"
}

// MARK: - Change Listener
extension NSObject
{
    final func removeChangeListener()
    {
        _changeListener.removeAllObjects()
    }
}

extension NSObjectProtocol where Self: NSObject
{
    func addChangeListener<T>(_ keyPath: KeyPath<Self, T>,
                              _ callback: @escaping (NSKeyValueObservedChange<T>) -> Void)
    {
        guard let key = keyPath._kvcKeyPathString else { return }

        let observer = observe(keyPath, options: [.old, .new])
        {
            callback($1)
        }

        _changeListener[key] = observer
    }
}

private extension NSObject
{
    var _changeListener: NSMutableDictionary
    {
        if
            let result = objc_getAssociatedObject(self, &AssociatedKey.ChangeListener)
            as? NSMutableDictionary
        {
            return result
        }

        let result = NSMutableDictionary()

        objc_setAssociatedObject(
            self, &AssociatedKey.ChangeListener, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return result
    }
}
