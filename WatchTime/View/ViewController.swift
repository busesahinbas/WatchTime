//
//  ViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 24.03.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        guard let email = mailTextField.text, !email.isEmpty,
                      let password = passwordTextField.text, !password.isEmpty
                else {
                    // Show an alert to the user indicating that all fields are required
                    makeAlert(title: .warning, description: MessageDescription.mailPass.rawValue, view: self)
                    return
                }
                
                // Sign in the user with the email and password provided
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                        // Show an alert to the user indicating that sign in failed
                        makeAlert(title: .error, description: error.localizedDescription, view: self)
                        return
                    }
                    
                    // Print the user's display name
                    if let user = Auth.auth().currentUser {
                        print("User signed in with display name: \(user.displayName ?? "N/A")")
                    
                    }
                    
                    // Navigate to the main screen
                    self.performSegue(withIdentifier: "signInSegue", sender: nil)
                     
                }
    }
    
    
    @IBAction func forgetPasswordClicked(_ sender: Any) {
        guard let email = mailTextField.text, !email.isEmpty else {
                      // Show an alert to the user indicating that the email field is required
                 makeAlert(title: .warning, description: MessageDescription.mail.rawValue, view: self)
                      return
                  }
                  
                  Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                      if let error = error {
                          // Show an alert to the user indicating that password reset failed
                          makeAlert(title: .error, description: error.localizedDescription, view: self)
                          return
                      }
                      
                      // Show an alert to the user indicating that password reset instructions have been sent
                      makeAlert(title: .resetPass, description: "Password reset instructions have been sent to your email", view: self)
                  }
    }
    
    @IBAction func createUserClicked(_ sender: Any) {
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
             navigationController?.pushViewController(vc2!, animated: true)
    }
}

