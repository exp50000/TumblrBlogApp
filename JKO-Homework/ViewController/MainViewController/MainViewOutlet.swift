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
//            setupTableViewHeader()
            registerTableViewCell()
            
//            tableView.rowHeight = UITableView.automaticDimension
//            tableView.estimatedRowHeight = 60
            
//            tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBOutlet weak var background: UIView!
    
    var titleHeaderView: TitleHeaderView = TitleHeaderView.FromNib()
    
    var constant: CGFloat = 0
}


extension MainViewOutlet {
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "TitleHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "TitleHeaderCell", bundle: nil), forCellReuseIdentifier: "Header")
    }
    
    func addExtensionView(in navigationBar: UINavigationBar) {
        
    }
    
    func setupTableViewHeader() {
        titleHeaderView.translatesAutoresizingMaskIntoConstraints = true
        
        titleHeaderView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

        tableView.tableHeaderView = titleHeaderView
        tableView.tableHeaderView?.layoutIfNeeded()
    }
}

extension MainViewOutlet {
    
    func updateHeaderView(by offset: CGFloat) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleHeaderCell else {
            return
        }
        
        let height = cell.refreshIndicatorHeightConstraint.constant - offset
        if height < 0 {
            cell.updateRefreshIndicatorHeight(0)
        } else {
            cell.updateRefreshIndicatorHeight(height)
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func resetHeaderView() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleHeaderCell else {
            return
        }
        
        cell.updateRefreshIndicatorHeight(0)
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
