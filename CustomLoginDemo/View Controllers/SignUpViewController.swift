//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Heritiana RASOANAIVO on 05/05/2020.
//  Copyright © 2020 Heritiana RASOANAIVO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }

    
    func setUpElements() {
           
           // Hide the error label
           errorLabel.alpha = 0
           
           // Style the elements
           Utilities.styleTextField(firstNameTextField)
           Utilities.styleTextField(lastNameTextField)
           Utilities.styleTextField(emailTextField)
           Utilities.styleTextField(passwordTextField)
           Utilities.styleFilledButton(signUpButton)
           
       }
    
    //check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func valdidateFields () -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields"
        
         }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password is'nt secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate the fields
        let error = valdidateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
            
        }
        else {
            // create the user
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
                // check for errors
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating the user")
                }
                else {
                    // User was created successfully, now store the first name and the last name
                    let db = Firestore.firestore()
                    
                }
            }
            
            // transition to the home screen
             
        }
        
    }
    
    func showError(_ message: String) {
         errorLabel.text = message
         errorLabel.alpha = 1
    }
   
    
}
