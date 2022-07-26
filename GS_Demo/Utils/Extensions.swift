//
//  Extensions.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//
import Foundation
import UIKit

// MARK: - Date Extension

extension Date {
    func getDateString(format: String = "YYYY-MM-dd") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// MARK: - String Extension

extension String {
    func getDate(format: String = "YYYY-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

// MARK: - UITextField Extension

extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            barButtonItem.tintColor = .label
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = .now
        if let date = "1995-06-16".getDate() {
            datePicker.minimumDate = date
        }
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        toolBar.tintColor = .systemBackground
        self.inputAccessoryView = toolBar
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

// MARK: - UIViewController Extension

extension UIViewController {

    func addAnimationToNavController(duration: Double = 0.4, isFromLeft: Bool, transitionType: String = "flip") {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType(rawValue: transitionType)
        transition.subtype = isFromLeft ? .fromLeft : .fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
}
