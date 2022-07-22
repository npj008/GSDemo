//
//  DateSelectorView.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import UIKit

class DateSelectorView: UIView {
    
    lazy var txtField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        setupTextField()
    }
    
    func setupTextField() {
        addSubview(txtField)
        txtField.accessibilityIdentifier = "txt_date_picker"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        txtField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        txtField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        txtField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        txtField.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .date)
        txtField.tintColor = .tintColor
        txtField.attributedPlaceholder = NSAttributedString(
            string: "Date for Astronomy Picture of the Day",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        txtField.layer.masksToBounds = true
        txtField.layer.borderColor = UIColor.tertiaryLabel.cgColor
        txtField.layer.borderWidth = 2.0
        txtField.layer.cornerRadius = 5.0
        txtField.setLeftPaddingPoints(10.0)
    }
    
    @objc
    func cancelAction() {
        txtField.resignFirstResponder()
    }

    @objc
    func doneAction() {
        if let datePickerView = txtField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            txtField.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            txtField.resignFirstResponder()
        }
    }
}
