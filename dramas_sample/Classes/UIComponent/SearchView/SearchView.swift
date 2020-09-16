//
//  SearchView.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit
import LCNibBridge

/// 提供搜尋的行為對象
protocol SearchViewDelegate: AnyObject {
    func searchView(_ searchView: SearchView, didChanged text: String)
    func searchViewDicCancel()
}

/// 搜尋UI的共用元件
class SearchView: UIView, LCNibBridge {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonTrailingConstraint: NSLayoutConstraint!
    
    weak var delegate: SearchViewDelegate?
    
    deinit {
        debugPrint(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = 20.0
        cancelButton.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        isHiddenCancelButtonWidth(true, isAnimation: false)
    }

    /// 取消按鈕事件
    @IBAction func cancelButtonAction(_ sender: Any) {
        textField.text = ""
        textField.resignFirstResponder()
        delegate?.searchViewDicCancel()
    }
    
    /// 輸入文字事件
    @IBAction func searchTextDidChanged(_ sender: UITextField) {
        if sender.markedTextRange == nil, let text = sender.text {
            delegate?.searchView(self, didChanged: text)
        }
    }
}

extension SearchView {
    /// 顯示或是隱藏取消按鈕
    private func isHiddenCancelButtonWidth(_ isHidden: Bool, isAnimation: Bool = true) {
        cancelButton.isHidden = isHidden
        cancelButtonTrailingConstraint.constant = isHidden ? -52.0 : 0.0
        
        if isAnimation {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isHiddenCancelButtonWidth(false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isHiddenCancelButtonWidth(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
