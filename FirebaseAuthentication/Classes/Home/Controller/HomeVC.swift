//
//  HomeVC.swift
//  FirebaseAuthentication
//
//  Created by Nirzar Gandhi on 08/10/25.
//

import UIKit
import FirebaseAuth

class HomeVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var logoutBtnBottom: NSLayoutConstraint!
    
    
    // MARK: - Properties
    fileprivate let spinner = HVDOverlayExtended.spinnerOverlay()
    
    
    // MARK: -
    // MARK: - View init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.addLeftBarButton(isShow: false)
        
        self.setControlsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    fileprivate func setControlsProperty() {
        
        self.view.backgroundColor = .getBgColor()
        
        // Logout Buttton
        self.logoutBtn.backgroundColor = .getButtonBgColor()
        self.logoutBtn.titleLabel?.backgroundColor = .getButtonBgColor()
        self.logoutBtn.setTitleColor(.getButtonTextColor(), for: .normal)
        self.logoutBtn.solidFilledBtn(radius: 10)
        self.logoutBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.logoutBtn.setTitle("Log Out", for: .normal)
        self.logoutBtn.startAnimatingPressActions()
        
        self.logoutBtnBottom.constant = UIDevice.current.hasNotch ? getBottomSafeAreaHeight() : 20
    }
}


//MARK: - Call Back
extension HomeVC {
    
    fileprivate func showSpinner() {
        self.spinner?.show(on: APPDELEOBJ.window)
    }
    
    fileprivate func hideSpinner() {
        self.spinner?.dismiss()
    }
}


// MARK: - Button Touch & Action
extension HomeVC {
    
    @IBAction func logoutBtnTouch(_ sender: Any) {
        
        self.showSpinner()
        
        do {
            
            try Auth.auth().signOut()
            self.hideSpinner()
            setRootSignInVC()
            
        } catch {
            
            toastMessage(messageStr: "Error signing out: \(error.localizedDescription)")
            self.hideSpinner()
        }
    }
}
