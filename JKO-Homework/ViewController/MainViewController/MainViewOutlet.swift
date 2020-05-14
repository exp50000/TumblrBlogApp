//
//  MainViewOutlet.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/4/30.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import AudioToolbox


class MainViewOutlet: NSObject {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerTableViewCell()
        }
    }
    
    @IBOutlet weak var nameButton: UIButton!
    
    @IBOutlet weak var errorView: UIView!
    
    private var lastContentOffset: CGPoint = .zero
    
    private(set) var isRefreshing = false
}


extension MainViewOutlet {
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "InfoHeaderCell", bundle: nil), forCellReuseIdentifier: InfoHeaderCell.cellIdentifier)
        tableView.register(UINib(nibName: "TextPostCell", bundle: nil), forCellReuseIdentifier: TextPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "PhotoPostCell", bundle: nil), forCellReuseIdentifier: PhotoPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "QuotePostCell", bundle: nil), forCellReuseIdentifier: QuotePostCell.cellIdentifier)
        tableView.register(UINib(nibName: "LinkPostCell", bundle: nil), forCellReuseIdentifier: LinkPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "ChatPostCell", bundle: nil), forCellReuseIdentifier: ChatPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: VideoPostCell.cellIdentifier)
        tableView.register(UINib(nibName: "AnswerPostCell", bundle: nil), forCellReuseIdentifier: AnswerPostCell.cellIdentifier)
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
                
                if !scrollView.isDecelerating &&
                    lastContentOffset.y > -63 &&
                    scrollView.contentOffset.y < -61 &&
                    !isRefreshing {
                    
                    NotificationCenter.default.post(name: NSNotification.Name("Refresh"), object: scrollView)
                    isRefreshing = true
                    
                    vibrate()
                }
                
                if !scrollView.isDragging &&
                    lastContentOffset.y < -61 &&
                    scrollView.contentOffset.y > -65 {
                    scrollView.setContentOffset(CGPoint(x: 0, y: -60), animated: false)
                    cell.frame = CGRect(
                        x: 0.0,
                        y: scrollView.contentOffset.y,
                        width: cell.frame.size.width,
                        height: originRowHeight + 60)

                    lastContentOffset = CGPoint(x: 0, y: -60)
                    
                    return
                }
                
                lastContentOffset = scrollView.contentOffset
            }
        }
    }
    
    func stopRefreshing() {
        self.isRefreshing = false
    }
}

extension MainViewOutlet {
    
    func startFetching() {
        tableView.tableFooterView = {
            let result = UIActivityIndicatorView(style: .gray)
            result.startAnimating()
            return result
        }()
    }
    
    func finishFetching() {
        tableView.tableFooterView = nil
    }
}

extension MainViewOutlet {
    
    func startLoading() {
        tableView.backgroundView = {
            let result = UIActivityIndicatorView(style: .gray)
            result.startAnimating()
            return result
        }()
    }
    
    func finishLoading() {
        tableView.backgroundView = nil
    }
    
    func finishLoadingWithError() {
        tableView.backgroundView = errorView
    }
}

private extension MainViewOutlet {
    func vibrate() {
        // 1519(輕微短震動) 1520(稍大力短震動) 1521(輕微三連短震動) 1102(1519+1520) 1107(稍大力三連短震動)
        let peek = SystemSoundID(1519)
        AudioServicesPlaySystemSound(peek)
    }
}
