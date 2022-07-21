//
//  BaseViewController.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = String(describing: type(of: self))
        self.view.backgroundColor = UIColor.systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationRouter.shared.currentViewController = self
    }
}
