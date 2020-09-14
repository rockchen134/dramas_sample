//
//  SearchView.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit
import LCNibBridge

protocol SearchViewDelegate {
    func searchView(_ searchView: SearchView, didChanged text: String)
    func searchViewDicCancel()
}

class SearchView: UIView, LCNibBridge {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var delegate: SearchViewDelegate?
    
    deinit {
        debugPrint(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView.layer.cornerRadius = 20.0
    }

    
    @IBAction func cancelButtonAction(_ sender: Any) {
        textField.text = ""
        textField.resignFirstResponder()
        delegate?.searchViewDicCancel()
    }
    
    @IBAction func searchTextDidChanged(_ sender: UITextField) {
        if sender.markedTextRange == nil, let text = sender.text {
            delegate?.searchView(self, didChanged: text)
        }
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
