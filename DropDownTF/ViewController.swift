//
//  ViewController.swift
//  DropDownTF
//
//  Created by Tim Beals on 2018-11-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var dropDown: DropDownTextField!
    private var flavourOptions = ["Chocolate", "Vanilla", "Strawberry", "Banana", "Lime"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layoutMargins = UIEdgeInsets(top: self.view.layoutMargins.top,
                                               left: 12.0,
                                               bottom: self.view.layoutMargins.bottom,
                                               right: 12.0)
        view.backgroundColor = UIColor.white
        addDropDown()
    }

    private func addDropDown() {
        let lm = view.layoutMargins
        let height: CGFloat = 40.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 60, width: view.bounds.width - (2 * lm.left), height: height)
        dropDown = DropDownTextField(frame: dropDownFrame, title: "Select Flavour", options: flavourOptions)
        dropDown.delegate = self
        view.addSubview(dropDown)
    }
}


//MARK: Drop down textfield delegate
extension ViewController: DropDownTextFieldDelegate {
    
    func menuDidAnimate(up: Bool) {
        print("animating up: \(up)")
    }

    func optionSelected(option: String) {

        print("option selected: \(option)")

    }
}
