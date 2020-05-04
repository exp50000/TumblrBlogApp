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
    var viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChangeListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutlet.setupNavigationBar(navigationController?.navigationBar)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! InfoHeaderCell
            
            if let info = viewModel.infoHeaderCellViewModel {
                cell.configure(viewModel: info)
            }
            
            return cell
        }
        
        let post = viewModel.postCellViewModels[indexPath.row - 1]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoPostCell
        cell.configure(viewModel: post)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let info = viewModel.infoHeaderCellViewModel {
                return info.cellHeight
            }
            return 120
        }

        let post = viewModel.postCellViewModels[indexPath.row - 1]
        return post.cellHeight
    }
}

extension MainViewController {
    
    func setupChangeListener() {
        viewModel.addChangeListener(\.apiInfoStatus) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            switch self.viewModel.apiInfoStatus {
            case .success:
                self.title = self.viewModel.blogerInfo?.name
                
                self.viewOutlet.tableView.beginUpdates()
                self.viewOutlet.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.viewOutlet.tableView.endUpdates()
            default: return
            }
        }
        
        viewModel.addChangeListener(\.apiPostsStatus) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            switch self.viewModel.apiPostsStatus {
            case .success:
                self.viewOutlet.tableView.reloadData()
            default: return
            }
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewOutlet.updateHeader(in: scrollView, originRowHeight: viewModel.infoHeaderCellViewModel?.cellHeight ?? 120)
    }
}
