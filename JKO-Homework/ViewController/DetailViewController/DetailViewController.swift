//
//  DetailViewController.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/5.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var viewOutlet: DetailViewOutlet!
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChangeListener()
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.cellViewModel else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(for: cellViewModel), for: indexPath)
        
        if let cell = cell as? PostDetailCellConfigurable {
            cell.configure(viewModel: cellViewModel)
        }
        
        if let cell = cell as? VideoPostDetailCell {
            cell.needReload = {
                UIView.performWithoutAnimation {
                    self.viewOutlet.tableView.beginUpdates()
                    self.viewOutlet.tableView.endUpdates()
                }
            }
        }
        
        return cell
    }
}

private extension DetailViewController {
    
    func cellIdentifier(for viewModel: PostDetailCellViewModel) -> String {
        switch viewModel {
        case is TextPostDetailCellViewModel:
            return TextPostDetailCell.cellIdentifier
        case is PhotoPostDetailCellViewModel:
            return PhotoPostDetailCell.cellIdentifier
        case is QuotePostDetailCellViewModel:
            return QuotePostDetailCell.cellIdentifier
        case is LinkPostDetailCellViewModel:
            return LinkPostDetailCell.cellIdentifier
        case is ChatPostDetailCellViewModel:
            return ChatPostDetailCell.cellIdentifier
        case is VideoPostDetailCellViewModel:
            return VideoPostDetailCell.cellIdentifier
        case is AnswerPostDetailCellViewModel:
            return AnswerPostDetailCell.cellIdentifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
}

extension DetailViewController {
    
    func setupChangeListener() {
        
        viewModel?.addChangeListener(\.apiStatus) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            switch self.viewModel?.apiStatus {
            case .success:
                self.viewOutlet.tableView.beginUpdates()
                self.viewOutlet.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.viewOutlet.tableView.endUpdates()
            default: return
            }
        }
    }
}

