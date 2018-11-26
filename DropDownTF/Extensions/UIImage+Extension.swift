//
//  UIImage+Extension.swift
//  DropDownTF
//
//  Created by Tim Beals on 2018-11-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit


extension UIImage {
    
    enum Theme {
        case triangle
        
        var name: String {
            switch self {
            case .triangle: return "triangle"
            }
        }
            
        var image: UIImage {
            return UIImage(named: self.name)!
        }
    }
}

