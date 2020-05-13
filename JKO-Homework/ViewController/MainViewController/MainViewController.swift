//
//  MainViewController.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/4/30.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import AudioToolbox

class MainViewController: BaseViewController {
    
    struct Storyboard {
        struct Segue {
            static let showDetailView = "ShowDetailViewSegue"
        }
    }
    
    @IBOutlet weak var viewOutlet: MainViewOutlet!
    var viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChangeListener()
        setupNotificationObserver()
        setupTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutlet.setupNavigationBar(navigationController?.navigationBar)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return viewModel.postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoHeaderCell.cellIdentifier, for: indexPath) as! InfoHeaderCell
            
            let info = viewModel.infoHeaderCellViewModel ?? InfoHeaderCellViewModel()
            cell.configure(viewModel: info)
            
            return cell
        }
        
        let post = viewModel.postCellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(for: post), for: indexPath)
        
        if let cell = cell as? PostCellConfigurable {
            cell.configure(viewModel: post)
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) {
            if let info = viewModel.infoHeaderCellViewModel {
                return info.cellHeight
            }
            return 120
        }

        let post = viewModel.postCellViewModels[indexPath.row]
        return post.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else {
            return
        }
        
        let cellViewModel = viewModel.postCellViewModels[indexPath.row]
        let viewController = DetailViewController.FromStoryboard("Main")
        
        viewController.viewModel = DetailViewModel(blogID: viewModel.blogID, postID: cellViewModel.postID)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.row == viewModel.postCellViewModels.count - 1 &&
           viewModel.hasMoreToFetch {
            viewModel.fetchMorePosts()
        }
    }
}

extension MainViewController {
    
    func setupTitle() {
        navigationItem.titleView = viewOutlet.nameButton
    }
    
    @IBAction func nameButtonDidSelect(_ sender: UIButton) {
        let viewController = SwitchBlogerViewController.FromStoryboard("Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}

private extension MainViewController {
    
    func cellIdentifier(for viewModel: PostCellViewModel) -> String {
        switch viewModel {
        case is TextPostCellViewModel:
            return TextPostCell.cellIdentifier
        case is PhotoPostCellViewModel:
            return PhotoPostCell.cellIdentifier
        case is QuotePostCellViewModel:
            return QuotePostCell.cellIdentifier
        case is LinkPostCellViewModel:
            return LinkPostCell.cellIdentifier
        case is VideoPostCellViewModel:
            return VideoPostCell.cellIdentifier
        case is ChatPostCellViewModel:
            return ChatPostCell.cellIdentifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
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
                self.viewOutlet.nameButton.setTitle(self.viewModel.blogerInfo?.name, for: .normal)
            case .error:
                return self.viewOutlet.nameButton.setTitle(nil, for: .normal)
            default: break
            }
            
            self.viewOutlet.tableView.beginUpdates()
            self.viewOutlet.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            self.viewOutlet.tableView.endUpdates()
        }
        
        viewModel.addChangeListener(\.apiPostsStatus) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            if [APIStatus.success,
                APIStatus.empty,
                APIStatus.error].contains(self.viewModel.apiPostsStatus)  {
                if self.viewOutlet.isRefreshing {
                    
                    self.viewModel.isRefreshSuccess = true
                    let scrollView = self.viewOutlet.tableView as UIScrollView
                    if scrollView.isDragging ||
                        scrollView.isDecelerating {
                        return
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        scrollView.setContentOffset(.zero, animated: true)
                    }
                    
                    self.viewModel.isRefreshSuccess = false
                    return
                }
            }
            
            switch self.viewModel.apiPostsStatus {
            case .start:
                self.viewOutlet.startLoading()
                
            case .success:
                self.viewOutlet.finishLoading()
                self.viewOutlet.tableView.beginUpdates()
                self.viewOutlet.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                self.viewOutlet.tableView.endUpdates()
                
            case .empty:
                self.viewOutlet.tableView.reloadData()
                self.viewOutlet.finishLoading()
                
            case .error:
                self.viewOutlet.tableView.reloadData()
                self.viewOutlet.finishLoadingWithError()
                
            default: return
            }
        }
        
        viewModel.addChangeListener(\.apiMorePostsStatus) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.viewOutlet.finishFetching()
            
            switch self.viewModel.apiMorePostsStatus {
            case .start:
                self.viewOutlet.startFetching()
                
            case .success:
                // 目前總數減掉最近新增的筆數的index，才是要插入cell的起點
                let count = self.viewModel.postCellViewModels.count - self.viewModel.lastRequestPostCount
                let indexPaths: [IndexPath] = {
                    var result = [IndexPath]()
                    for i in 0..<self.viewModel.lastRequestPostCount {
                        result.append(IndexPath(row: count + i, section: 1))
                    }
                    return result
                }()
                
                self.viewOutlet.tableView.beginUpdates()
                self.viewOutlet.tableView.insertRows(at: indexPaths, with: .fade)
                self.viewOutlet.tableView.endUpdates()
                
                self.viewOutlet.tableView.layoutIfNeeded()
                
            default: return
            }
        }
    }
    
    func setupNotificationObserver() {
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("Refresh"),
            object: nil,
            queue: nil) { [weak self] notification in
                guard let self = self else {
                    return
                }
                
                if self.viewOutlet.isRefreshing {
                    return
                }
                
                self.viewModel.getPost()
        }
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("BlogChanged"),
            object: nil,
            queue: nil) { [weak self] notification in
                guard let self = self else {
                    return
                }
                
                self.viewModel.getInfo()
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewOutlet.updateHeader(in: scrollView, originRowHeight: viewModel.infoHeaderCellViewModel?.cellHeight ?? 120)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if viewOutlet.isRefreshing && viewModel.isRefreshSuccess {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                scrollView.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if viewOutlet.isRefreshing {
            switch viewModel.apiPostsStatus {
            case .success, .empty: viewOutlet.finishLoading()
            case .error: viewOutlet.finishLoadingWithError()
            default: break
            }
           
            self.viewOutlet.tableView.beginUpdates()
            self.viewOutlet.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            self.viewOutlet.tableView.endUpdates()
            
            self.viewOutlet.stopRefreshing()
        }
    }
}
