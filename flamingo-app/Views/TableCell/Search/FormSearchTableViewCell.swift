//
//  FormSearchTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class FormSearchTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var txtStartDate: UILabel!
    @IBOutlet weak var txtEndDate: UILabel!
    
    var callbackSearch: ((String) -> (Void))!
    
    
    @IBOutlet weak var textFielSearch: TextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let imageView = UIImageView();
        let image = UIImage(named: "btn_search");
        imageView.image = image;
        txtSearch.leftViewMode = .always
        
        self.textFielSearch.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        self.callbackSearch?(self.txtSearch.text!)
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
