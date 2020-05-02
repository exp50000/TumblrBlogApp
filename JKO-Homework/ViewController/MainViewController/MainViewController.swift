//
//  MainViewController.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/4/30.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var viewOutlet: MainViewOutlet!
    
    var lastContentOffset: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewOutlet.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! TitleHeaderCell
            cell.configure()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }

        return 60
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            if let cell = viewOutlet.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                
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
                        height: 160)

                    lastContentOffset = CGPoint(x: 0, y: -60)

                }
                
                lastContentOffset = scrollView.contentOffset
            }
        }
    }
}
