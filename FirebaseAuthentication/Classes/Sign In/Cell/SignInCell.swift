//
//  SignInCell.swift
//  FirebaseAuthentication
//
//  Created by Nirzar Gandhi on 07/10/25.
//

import UIKit

class SignInCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailIdTF: FloatingLabelTextField!
    @IBOutlet weak var passwordTF: FloatingLabelTextField!
    
    
    // MARK: - Cell init methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .getClearColour()
        self.selectionStyle = .none
        
        // Container
        self.container.backgroundColor = .getClearColour()
        
        // StackView
        self.stackView.backgroundColor = .getClearColour()
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 30
        
        // Email Id TextField
        self.emailIdTF.keyboardType = .emailAddress
        self.emailIdTF.updateProperty(placeholderText: "Enter email id", floatingLabelText: "Email Id")
        self.emailIdTF.text = ""
        
        // Password TextField
        self.passwordTF.keyboardType = .emailAddress
        self.passwordTF.updateProperty(placeholderText: "Enter password", floatingLabelText: "Password")
        self.passwordTF.isSecureTextEntry = true
        self.passwordTF.text = ""
    }
    
    
    // MARK: - Cell Configuration
    func configureCell(emailId: String, password: String) {
        
        // Email Id TextField
        self.emailIdTF.text = emailId
        self.emailIdTF.updateTextFieldUI()
        
        // Password TextField
        self.passwordTF.text = password
        self.passwordTF.updateTextFieldUI()
    }
}
