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
        tableView.register(UINib(nibName: "InfoHeaderCell", bundle: nil), forCellReuseIdentifier: InfoHeaderCell.cellIdentifier)
        tableView.register(UINib(nibName: "TextPostCell", bundle: nil), forCellReuseIdentifier: TextPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "PhotoPostCell", bundle: nil), forCellReuseIdentifier: PhotoPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "QuotePostCell", bundle: nil), forCellReuseIdentifier: QuotePostCell.cellIdentifier)
        tableView.register(UINib(nibName: "LinkPostCell", bundle: nil), forCellReuseIdentifier: LinkPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "ChatPostCell", bundle: nil), forCellReuseIdentifier: ChatPostCell.cellIdentifier)
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
