//
//  AppDelegate.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private(set) var coreData: CoreDataManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let vc = APODViewController()
        let mainNav = UINavigationController(rootViewController: vc)
        mainNav.isNavigationBarHidden = false
        mainNav.navigationBar.isTranslucent = false
        NavigationRouter.shared.mainNavigation = mainNav
        NavigationRouter.shared.currentViewController = vc
        window?.rootViewController = mainNav
        
        coreData = CoreDataManager(modelName: "GS_Demo")
        return true
    }
}

