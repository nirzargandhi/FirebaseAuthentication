//
//  Constants.swift
//  FirebaseAuthentication
//
//  Created by Nirzar Gandhi on 07/10/25.
//

import Foundation
import UIKit

let BASEWIDTH = 375.0
let SCREENSIZE: CGRect      = UIScreen.main.bounds
let SCREENWIDTH             = UIScreen.main.bounds.width
let SCREENHEIGHT            = UIScreen.main.bounds.height
let WINDOWSCENE             = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.first
let STATUSBARHEIGHT         = WINDOWSCENE?.statusBarManager?.statusBarFrame.size.height
var NAVBARHEIGHT            = 44.0

let APPDELEOBJ  = UIApplication.shared.delegate as! AppDelegate
let NC = NotificationCenter.default

struct Constants {
    
    struct Storyboard {
        
        static let Main = "Main"
    }
    
    struct Generic {
        
        // Messages
        static let EmailEmpty = "Email address is empty"
        static let EmailInvalid = "Email address is invalid"
        
        static let PasswordEmpty = "Password is empty"
        static let PasswordInvalid = "Password is invalid"
    }
}
