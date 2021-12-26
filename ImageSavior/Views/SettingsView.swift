//
//  SettingsView.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 26.12.2021.
//

import Foundation
import UIKit

typealias VoidHandler = () -> Void
typealias PasswordChangeClickHandler = (String) -> Void

class SettingsView : UIView {
    
    @objc private func handleSortingToggleEvent(item: UISwitch) {
        sortingOptionsItem.isUserInteractionEnabled = item.isOn
    }
    
    public var passwordChangeHandler : VoidHandler?
    
    private let sortingLabel : UILabel = {
        let view = UILabel()
        view.text = "Enable Sorting"
        view.numberOfLines = 1
        view.textColor = UIColor.black
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        return view
    }()

    public var sortingEnabled : Bool {
        
        get {
            return sortingEnabledItem.isOn == true
        }
        
        set {
            sortingEnabledItem.setOn(newValue, animated: true)
            sortingOptionsItem.isUserInteractionEnabled = newValue
        }
    }
    
    public var ascendingOrder : Bool {
        
        get {
            return sortingOptionsItem.selectedSegmentIndex == 0
        }
        
        set {
            if newValue {
                sortingOptionsItem.selectedSegmentIndex = 0
            } else {
                sortingOptionsItem.selectedSegmentIndex = 1
            }
        }
    }
    
    private lazy var sortingEnabledItem : UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(handleSortingToggleEvent), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setOn(false, animated: false)
        return view
    }()
    
    private lazy var sortingOptionsItem : UISegmentedControl = {
        let view = UISegmentedControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.insertSegment(withTitle: "Ascending", at: 0, animated: false)
        view.insertSegment(withTitle: "Descending", at: 1, animated: false)
        return view
    }()
    
    @objc private func changePasswordHandler() {
        passwordChangeHandler?()
    }
    
    private lazy var changePasswordButtonItem : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Change password", for: .normal)
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        view.tintColor = .white
        view.addTarget(self, action: #selector(changePasswordHandler), for: .touchUpInside)
        return view
    }()
    
    private func addSubviews() {
        addSubview(sortingLabel)
        addSubview(sortingEnabledItem)
        addSubview(sortingOptionsItem)
        addSubview(changePasswordButtonItem)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        addSubviews()

        let constraints = [
            sortingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            sortingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            sortingEnabledItem.topAnchor.constraint(equalTo: sortingLabel.topAnchor),
            sortingEnabledItem.leadingAnchor.constraint(equalTo: sortingLabel.trailingAnchor, constant: 30),

            sortingOptionsItem.topAnchor.constraint(equalTo: sortingLabel.bottomAnchor, constant: 16),
            sortingOptionsItem.leadingAnchor.constraint(equalTo: sortingLabel.leadingAnchor),
            sortingOptionsItem.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            changePasswordButtonItem.topAnchor.constraint(equalTo: sortingOptionsItem.bottomAnchor, constant: 16),
            changePasswordButtonItem.leadingAnchor.constraint(equalTo: sortingOptionsItem.leadingAnchor),
            changePasswordButtonItem.trailingAnchor.constraint(equalTo: sortingOptionsItem.trailingAnchor),
            
            changePasswordButtonItem.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    init(viewFrame : CGRect) {
        super.init(frame: viewFrame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for SettingsView")
    }
}
