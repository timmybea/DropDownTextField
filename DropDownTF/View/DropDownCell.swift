//
//  DropDownCell.swift
//  DropDownTF
//
//  Created by Tim Beals on 2018-11-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {
    
    var lightColor = UIColor.lightGray
    var cellFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with title: String) {
        self.selectionStyle = .none
        self.textLabel?.font = cellFont
        self.textLabel?.textColor = self.lightColor
        self.backgroundColor = UIColor.clear
        self.textLabel?.text = title
    }
}
