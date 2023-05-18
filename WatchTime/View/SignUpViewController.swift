//
//  SignUPViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 10.05.2023.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        guard let email = mailTextField.text, !email.isEmpty,
              let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmTextField.text, !confirmPassword.isEmpty
        else {
            // Show an alert to the user indicating that all fields are required
            makeAlert(title: .warning, description: MessageDescription.fields.rawValue, view: self)
            return
        }
        
        guard password == confirmPassword else {
            makeAlert(title: .warning, description: MessageDescription.confirmPass.rawValue, view: self)
            return
        }
        
        // Create a new user account with the email and password provided
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Show an alert to the user indicating that account creation failed
                makeAlert(title: .error, description: error.localizedDescription, view: self)
                return
            }
            
            // Set the user's display name
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: nil)
            
            //TODO: go back sign in page
        }
    }
}
