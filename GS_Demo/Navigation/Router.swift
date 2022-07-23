//
//  Router.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation
import UIKit

final class NavigationRouter {
    
    static let shared = NavigationRouter()
    
    var mainNavigation: UINavigationController?
    
    var currentViewController: UIViewController?
    
    private init() {
        //
    }
    
    func presentAlertWithTitle(title: String, message : String, onDismiss: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.view.accessibilityIdentifier = "alert_view"
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in print("You have pressed OK Button")
                onDismiss?()
            }

            alertController.addAction(OKAction)
            self?.currentViewController?.present(alertController,
                                                 animated: true,
                                                 completion: nil)
        }
    }
    
    func openURLExternally(url: URL) {
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
