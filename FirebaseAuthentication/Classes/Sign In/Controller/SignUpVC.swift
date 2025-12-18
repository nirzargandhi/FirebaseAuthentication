//
//  SignUpVC.swift
//  FirebaseAuthentication
//
//  Created by Nirzar Gandhi on 07/10/25.
//

import UIKit
import FirebaseAuth

class SignUpVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var signUpBtnBottom: NSLayoutConstraint!
    
    
    // MARK: - Properties
    fileprivate var refEmailIdTF: FloatingLabelTextField?
    fileprivate var refPasswordTF: FloatingLabelTextField?
    
    fileprivate lazy var emailId = ""
    fileprivate lazy var password = ""
    
    fileprivate lazy var bottomConstant: CGFloat = 30
    
    fileprivate let spinner = HVDOverlayExtended.spinnerOverlay()
    
    
    // MARK: -
    // MARK: - View init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        self.setControlsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setControlsProperty() {
        
        self.view.backgroundColor = .getBgColor()
        
        // Tableview
        self.tableView.backgroundColor = .getClearColour()
        
        self.tableView.tag = 0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.tableFooterView = UIView().addTableFooter(height: UIDevice.current.hasNotch ? getBottomSafeAreaHeight() : 20)
        self.tableView.tableFooterView?.backgroundColor = .getClearColour()
        
        // Sign Up Buttton
        self.signUpBtn.backgroundColor = .getButtonBgColor()
        self.signUpBtn.titleLabel?.backgroundColor = .getButtonBgColor()
        self.signUpBtn.setTitleColor(.getButtonTextColor(), for: .normal)
        self.signUpBtn.solidFilledBtn(radius: 10)
        self.signUpBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.signUpBtn.setTitle("Sign Up", for: .normal)
        self.signUpBtn.startAnimatingPressActions()
        
        self.signUpBtnBottom.constant = UIDevice.current.hasNotch ? getBottomSafeAreaHeight() : self.bottomConstant
    }
}


// MARK: - Call Back
extension SignUpVC {
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if SCREENHEIGHT <= 667 {
                return
            }
            
            self.signUpBtnBottom.constant = keyboardSize.height - getBottomSafeAreaHeight() + self.bottomConstant + (UIDevice.current.hasNotch ? 30 : 0)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        
        if SCREENHEIGHT <= 667 {
            return
        }
        
        self.signUpBtnBottom.constant = UIDevice.current.hasNotch ? getBottomSafeAreaHeight() : self.bottomConstant
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func checkValidation() -> Bool {
        
        var isValid = true
        
        if self.emailId.isEmpty {
            
            isValid = false
            toastMessage(messageStr: Constants.Generic.EmailEmpty)
            
        } else if !ValidationUtils.isValidEmail(self.emailId) {
            
            isValid = false
            toastMessage(messageStr: Constants.Generic.EmailInvalid)
            
        } else if self.password.isEmpty {
            
            isValid = false
            toastMessage(messageStr: Constants.Generic.PasswordEmpty)
            
        } else if !ValidationUtils.isValidPassword(self.password) {
            
            isValid = false
            toastMessage(messageStr: Constants.Generic.PasswordInvalid)
        }
        
        return isValid
    }
    
    fileprivate func showSpinner() {
        self.spinner?.show(on: APPDELEOBJ.window)
    }
    
    fileprivate func hideSpinner() {
        self.spinner?.dismiss()
    }
    
    fileprivate func resignAllTextFields() {
        
        self.refEmailIdTF?.resignFirstResponder()
        self.refPasswordTF?.resignFirstResponder()
    }
}


// MARK: - Button Touch & Action
extension SignUpVC {
    
    @IBAction func signUpBtnTouch(_ sender: Any) {
        
        self.resignAllTextFields()
        
        if checkValidation() {
            
            self.showSpinner()
            
            Auth.auth().createUser(withEmail: self.emailId, password: self.password) { authResult, error in
                
                if let error = error {
                    toastMessage(messageStr: "Sign-up failed: \(error.localizedDescription)")
                } else {
                    setRootHomeVC()
                }
                
                self.hideSpinner()
            }
        }
    }
}


// MARK: -
// MARK: - UITableView DataSource
extension SignUpVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "SignInCell") as? SignInCell
            if cell == nil {
                let nib = Bundle.main.loadNibNamed("SignInCell", owner: self, options: nil)
                cell = nib![0] as? SignInCell
            }
            
            cell?.emailIdTF.delegate = self
            cell?.passwordTF.delegate = self
            
            self.refEmailIdTF = cell?.emailIdTF
            self.refPasswordTF = cell?.passwordTF
            
            cell?.configureCell(emailId: self.emailId, password: self.password)
            
            self.refEmailIdTF?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            self.refPasswordTF?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            
            return cell!
            
        } else {
            return getTableCell()
        }
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}


// MARK: - UITextField Delegate
extension SignUpVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.refEmailIdTF || textField == self.refPasswordTF {
            
            if range.location == 0 && string == " " {
                return false
            }
            
            if string == " " || string == "\n" {
                return false
            }
        }
        
        return true
    }
    
    @objc fileprivate func textFieldDidChange(_ sender: UITextField) {
        
        if sender == self.refEmailIdTF {
            
            // Email Id TextField
            if let email = self.refEmailIdTF?.text, !email.isEmpty {
                self.emailId = email
            } else {
                self.emailId = ""
            }
            
        } else if sender == self.refPasswordTF {
            
            // Password TextField
            if let pass = self.refPasswordTF?.text, !pass.isEmpty {
                self.password = pass
            } else {
                self.password = ""
            }
        }
    }
}

