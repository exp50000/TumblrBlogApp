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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatPostDetailCell
        
        if let cellViewModel = viewModel?.cellViewModel {
            cell.configure(viewModel: cellViewModel)
        }
        
        return cell
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

