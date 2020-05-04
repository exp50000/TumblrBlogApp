//
//  MainViewOutlet.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/4/30.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class MainViewOutlet: NSObject {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerTableViewCell()
        }
    }
    
    private var lastContentOffset: CGPoint = .zero
    
    var headerHeight: CGFloat?
}


extension MainViewOutlet {
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "InfoHeaderCell", bundle: nil), forCellReuseIdentifier: "Header")
        tableView.register(UINib(nibName: "TextPostCell", bundle: nil), forCellReuseIdentifier: "TextCell")
    }
}

extension MainViewOutlet {
    
    func setupNavigationBar(_ navigationBar: UINavigationBar?) {
        guard let navigationBar = navigationBar else { return }
        
        let color = UIColor.white
        navigationBar.barTintColor = color
        navigationBar.shadowImage = UIImage()
    }
    
    func updateHeader(in scrollView: UIScrollView, originRowHeight: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                
                let deltaY = CGFloat(fabsf(Float(scrollView.contentOffset.y)) - fabsf(Float(lastContentOffset.y)))
                
                cell.frame = CGRect(
                    x: 0.0,
                    y: scrollView.contentOffset.y,
                    width: cell.frame.size.width,
                    height: cell.frame.size.height + deltaY)
                
                if !scrollView.isDragging && lastContentOffset.y < -61 && scrollView.contentOffset.y > -65 {
                    scrollView.setContentOffset(CGPoint(x: 0, y: -60), animated: false)
                    cell.frame = CGRect(
                        x: 0.0,
                        y: scrollView.contentOffset.y,
                        width: cell.frame.size.width,
                        height: originRowHeight + 60)

                    lastContentOffset = CGPoint(x: 0, y: -60)

                }
                
                lastContentOffset = scrollView.contentOffset
            }
        }
    }
}
