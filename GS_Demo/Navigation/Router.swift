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
}
