//
//  DramasListViewController.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit
import Kingfisher

/// 戲劇列表
class DramasListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var refreshControl: UIRefreshControl!
    
    fileprivate let viewModel = DramasListViewModel()
    
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
        super.viewWillAppear(animated)
        
        // 加入鍵盤彈出監聽事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 移除鍵盤彈出監聽事件
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 離線後 retry 的按鈕事件
    @IBAction func retryButtonAction(_ sender: Any) {
        viewModel.load()
    }
}

extension DramasListViewController {
    // 初始化參數或是UI
    private func setup() {
        title = NSLocalizedString("dramas_list_title", comment: "")
        
        retryButton.layer.cornerRadius = 15.0
        retryButton.isHidden = true
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        searchView.delegate = self
    }
    
    private func dataBind() {
        // 監聽取得資料的狀態
        viewModel.status.observer { [unowned self] (status) in
            switch status {
            case .none:
                debugPrint("none")
            case .start:
                self.retryButton.isHidden = true
                self.refreshControl.beginRefreshing()
            case .completed:
                self.retryButton.isHidden = true
                self.searchView.textField.text = self.viewModel.searchText
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            case .error(let error):
                debugPrint(error)
                self.alert("Oops!", message: error.localizedDescription) {
                    
                }
                self.refreshControl.endRefreshing()
            }
        }
        
        // 監聽搜尋的結果狀態
        viewModel.searchResult.observer { [unowned self] (_) in
            self.tableView.reloadData()
        }
        
        // 監聽網路狀態
        viewModel.offline.observer { (offline) in
            self.retryButton.isHidden = !offline
        }
        
        // 取得資料
        viewModel.load()
    }
    
    // 鍵盤彈出事件
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        bottomConstraint.constant = rect.cgRectValue.size.height
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
     }
    
    // 鍵盤隱藏事件
    @objc func keyboardWillHidden(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
         
        bottomConstraint.constant = 0.0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 下滑更新事件
    @objc func refreshAction(_ sedner: Any) {
        viewModel.load()
    }
}

// MARK: - UITableViewDataSource
extension DramasListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.value ? viewModel.filterDataSource.count : viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DramasListCell", for: indexPath) as! DramasListCell
        
        let data = viewModel.searchResult.value ? viewModel.filterDataSource[indexPath.row] : viewModel.dataSource[indexPath.row]
        
        cell.thumbImageView.kf.setImage(with: data.thumb)
        cell.nameLabel.text = data.name
        cell.createdAtLabel.text = data.createAt
        cell.ratingView.ratingLabel.text = data.rating
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension DramasListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = viewModel.searchResult.value ? viewModel.filterDataSource[indexPath.row] : viewModel.dataSource[indexPath.row]
        
        let dramasDetailViewController = storyboard?.instantiateViewController(withIdentifier: "DramasDetailViewController") as! DramasDetailViewController
        
        dramasDetailViewController.dramasModel = data
        navigationController?.pushViewController(dramasDetailViewController, animated: true)
    }
}

// MARK: - SearchViewDelegate
extension DramasListViewController: SearchViewDelegate {
    func searchView(_ searchView: SearchView, didChanged text: String) {
        viewModel.search(text)
    }
    
    func searchViewDicCancel() {
        viewModel.search("")
    }
}
