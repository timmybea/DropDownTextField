//
//  UIView+Extension.swift
//  DropDownTF
//
//  Created by Tim Beals on 2018-11-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintsPinTo(leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: leading),
            self.trailingAnchor.constraint(equalTo: trailing),
            self.topAnchor.constraint(equalTo: top),
            self.bottomAnchor.constraint(equalTo: bottom)
            ])
    }
}
