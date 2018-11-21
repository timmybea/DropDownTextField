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
    
    let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightText
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCellWith(title: String) {
        self.selectionStyle = .none
        self.textLabel?.font = cellFont
        self.textLabel?.textColor = self.lightColor
        self.backgroundColor = UIColor.clear
        
        self.textLabel?.text = title
        
        addSubview(whiteView)
        
        whiteView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        whiteView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
