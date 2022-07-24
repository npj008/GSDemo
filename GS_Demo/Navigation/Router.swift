//
//  Router.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation
import UIKit

// MARK: - NavigationRouter

final class NavigationRouter {
    
    static let shared = NavigationRouter()
    
    var mainNavigation: UINavigationController?
    var currentViewController: UIViewController?
    
    private init() {
        //
    }
    
    /**
   Method to Present Alert on `currentViewController`
    - Parameter title: Title for Alert view
    - Parameter message: Alert view message content
    - Parameter onDismiss: On dismiss completion handler
    */
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
    
    /**
   Method to navigate photo full screen view
    - Parameter photoDetails: Reference picture details for which Image needs to be shown
    */
    func navigateToPhotoDetails(photoDetails: PictureDetails) {
        DispatchQueue.main.async { [weak self] in
            let vc = PhotoViewController()
            vc.currentPost = photoDetails
            self?.currentViewController?.addAnimationToNavController(isFromLeft: true)
            self?.currentViewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /**
   Method to dismiss photo detail view
    */
    func dismissFromPhotoDetails() {
        DispatchQueue.main.async { [weak self] in
            self?.currentViewController?.addAnimationToNavController(isFromLeft: false)
            self?.currentViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    /**
   Method to open URL extenally
    - Parameter url: URL to open
    */
    func openURLExternally(url: URL) {
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
