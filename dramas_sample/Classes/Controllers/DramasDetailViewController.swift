//
//  DramasDetailViewController.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit
import Kingfisher

/// 戲劇資訊
class DramasDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var retryButton: UIButton!
    
    var dramasModel: DramasModel!
    
    fileprivate var viewModel: DramasDetailViewModel!
    
    deinit {
        debugPrint(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        dataBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.transparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.untransparent()
    }

    @IBAction func retryButtonAction(_ sender: Any) {
        viewModel.load()
    }
}

extension DramasDetailViewController {
    // 初始化參數或是UI
    private func setup() {
        retryButton.layer.cornerRadius = 15.0
        retryButton.isHidden = true
        viewModel = DramasDetailViewModel(dramasModel)
    }
    
    private func dataBind() {
        viewModel.offline.observer { [unowned self] (offline) in
            self.retryButton.isHidden = !offline
        }
        viewModel.load()
    }
}

// MARK: - UITableViewDataSource
extension DramasDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DramasDetailCell", for: indexPath) as! DramasDetailCell
        
        let data = viewModel.dataSource[indexPath.row]
        
        cell.thumbImageView.kf.setImage(with: data.thumb)
        cell.nameLabel.text = data.name
        cell.totalViewsLabel.text = String(format: NSLocalizedString("darams_detail_total_views", comment: ""), data.totalViews)
        cell.ratingView.ratingLabel.text = data.rating
        cell.createdAtLabel.text = data.createAt
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DramasDetailViewController: UITableViewDelegate {
    
}
