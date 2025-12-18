//
//  AppDelegate.swift
//  FirebaseAuthentication
//
//  Created by Nirzar Gandhi on 07/10/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    internal var window: UIWindow?
    var navController : UINavigationController?
    
    
    // MARK: - RootView Setup
    func setRootViewController(rootVC: UIViewController) {
        
        self.navController = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = self.navController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase Configuration
        FirebaseApp.configure()
        
        // Set Root Controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .getBgColor()
        
        if let _ = Auth.auth().currentUser {
            setRootHomeVC()
        } else {
            setRootSignInVC()
        }
        
        self.window?.makeKeyAndVisible()
        
        // Keyboard Appearance
        keyboardAppearance()
        
        // UIButton Appearance
        UIButton.appearance().isExclusiveTouch = true
        
        return true
    }
}

