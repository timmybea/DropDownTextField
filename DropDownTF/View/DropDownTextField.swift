//
//  DropDownTextField.swift
//  DropDownTF
//
//  Created by Tim Beals on 2018-11-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

//MARK: DropDownTextFieldDelegate
protocol DropDownTextFieldDelegate {
    func menuDidAnimate(up: Bool)
    func optionSelected(option: String)
}

//MARK: DropDownTextField: properties and init
class DropDownTextField: UIView {
    
    //public properties
    private var options: [String]
    
    var boldColor = UIColor.black
    var lightColor = UIColor.white
    var dropDownColor = UIColor.gray
    var font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    var delegate: DropDownTextFieldDelegate?

    //private properties
    private var isDroppedDown = false
    private var initialHeight: CGFloat = 0
    private let rowHeight: CGFloat = 40
    
    //UI properties
    var underline = UIView()
    
    let triangleIndicator: UIImageView = {
        let image = UIImage.Theme.triangle.image
        image.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tapView: UIView = UIView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DropDownCell.self, forCellReuseIdentifier: "option")
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        return tableView
    }()
    
    let animationView = UIView()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = boldColor
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        return textField
    }()
    
    init(frame: CGRect, title: String, options: [String]) {
        self.options = options
        super.init(frame: frame)
        self.textField.text = title
        calculateHeight()
        setupViews()
    }
    
    private override init(frame: CGRect) {
        options = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOptions(options: [String]) {
        self.options = options
        self.frame = CGRect(x: self.frame.origin.x,
                            y: self.frame.origin.y,
                            width: self.bounds.width,
                            height: initialHeight)
        calculateHeight()
        setupViews()
        layoutIfNeeded()
    }
    
    @objc func animateMenu() {
        menuAnimate(up: isDroppedDown)
    }
    
    func otherChosen() {
        animateMenu()
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
    func finishEditingTextField() {
        textField.resignFirstResponder()
    }
    
    func setTitle(text: String) {
        textField.text = text
    }
}

extension DropDownTextField {
    
    private func calculateHeight() {
        self.initialHeight = self.bounds.height
        let rowCount = self.options.count + 1 //Add one so that you can include 'other'
        let newHeight = self.initialHeight + (CGFloat(rowCount) * rowHeight)
        self.frame.size = CGSize(width: self.frame.width, height: newHeight)
    }
    
    private func setupViews() {
        removeSubviews()
        addUnderline()
        addTriangleIndicator()
        addTextField()
        addTapView()
        addTableView()
        addAnimationView()
    }
    
    private func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func addUnderline() {
        addSubview(underline)
        underline.backgroundColor = self.boldColor
        
        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.topAnchor.constraint(equalTo: topAnchor, constant: initialHeight - 2),
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 2)
            ])
    }
    
    private func addTriangleIndicator() {
        triangleIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(triangleIndicator)
        let triSize: CGFloat = 12.0
        NSLayoutConstraint.activate([
            triangleIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            triangleIndicator.heightAnchor.constraint(equalToConstant: triSize),
            triangleIndicator.widthAnchor.constraint(equalToConstant: triSize),
            triangleIndicator.centerYAnchor.constraint(equalTo: topAnchor, constant: initialHeight / 2)
            ])
    }
    
    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = UIColor.green
        self.addSubview(textField)
                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: leadingAnchor),
                    textField.centerYAnchor.constraint(equalTo: topAnchor, constant: initialHeight / 2),
                    textField.trailingAnchor.constraint(equalTo: triangleIndicator.leadingAnchor, constant: -8)
                    ])
        textField.font = self.font
        textField.delegate = self
    }
    
    private func addTapView() {
        tapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenu))
//        tapView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        tapView.addGestureRecognizer(tapGesture)
        addSubview(tapView)
        tapView.constraintsPinTo(leading: leadingAnchor, trailing: trailingAnchor, top: topAnchor, bottom: underline.bottomAnchor)
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        tableView.constraintsPinTo(leading: leadingAnchor, trailing: trailingAnchor, top: underline.bottomAnchor, bottom: bottomAnchor)
//        tableView.backgroundColor = UIColor.purple
        tableView.isHidden = true
    }
    
    private func addAnimationView() {

        self.addSubview(animationView)
        animationView.frame = CGRect(x: 0.0, y: initialHeight, width: bounds.width, height: bounds.height - initialHeight)
        self.sendSubviewToBack(animationView)
        animationView.backgroundColor = dropDownColor
        animationView.isHidden = true
    }
    
    private func menuAnimate(up: Bool) {
        let downFrame = animationView.frame
        let upFrame = CGRect(x: 0, y: self.initialHeight, width: self.bounds.width, height: 0)
        animationView.frame = up ? downFrame : upFrame
        animationView.isHidden = false
        tableView.isHidden = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animationView.frame = up ? upFrame : downFrame
        }, completion: { (bool) in
            self.isDroppedDown = !self.isDroppedDown
            self.animationView.isHidden = up
            self.animationView.frame = downFrame
            
            self.tableView.isHidden = up
            self.delegate?.menuDidAnimate(up: up)
        })
    }
    
}



extension DropDownTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let capitalized = text.capitalized
        textField.text = capitalized
        delegate?.optionSelected(option: capitalized)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
}

extension DropDownTextField: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "option") as? DropDownCell ?? DropDownCell()
        cell.lightColor = self.lightColor
        let title = indexPath.row < options.count ? options[indexPath.row] : "Other"
        cell.configureCellWith(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(options.count + 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == options.count {
            otherChosen()
        } else {
            let chosen = options[indexPath.row]
            textField.text = chosen
            self.delegate?.optionSelected(option: chosen)
            animateMenu()
        }
    }
}



