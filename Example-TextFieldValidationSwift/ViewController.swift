//
//  ViewController.swift
//  Example-TextFieldValidationSwift
//
//  Created by Mayur Vaity on 27/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var phoneNumberError: UILabel!
    @IBOutlet weak var amountError: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func resetForm() {
        submitButton.isEnabled = false
        
        emailError.isHidden = false
        passwordError.isHidden = false
        phoneNumberError.isHidden = false
        amountError.isHidden = false
        
        emailError.text = "Required"
        passwordError.text = "Required"
        phoneNumberError.text = "Required"
        amountError.text = "Required"
        
        emailTF.text = ""
        passwordTF.text = ""
        phoneNumberTF.text = ""
        amountTF.text = ""
        
    }
    
    //MARK: - Editing Changed Methods
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTF.text {
            if let errorMessage = invalidEmail(email) {
                emailError.text = errorMessage
                emailError.isHidden = false
            } else {
                emailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String? {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value) {
            return "Invalid email address."
        }
        
        return nil
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text {
            if let errorMessage = invalidPassword(password) {
                passwordError.text = errorMessage
                passwordError.isHidden = false
            } else {
                passwordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPassword(_ value: String) -> String? {
        
        if value.count < 8 {
            return "Password length must be at least 8 characters."
        }
        if containsDigit(value) {
            return "Password must contain at least 1 digit."
        }
        if containsLowerCase(value) {
            return "Password must contain at least 1 lowercase character."
        }
        if containsUpperCase(value) {
            return "Password must contain at least 1 uppercase character."
        }

        return nil
    }
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    @IBAction func phoneNumberChanged(_ sender: Any) {
        if let phoneNumber = phoneNumberTF.text {
            if let errorMessage = invalidPhoneNumber(phoneNumber) {
                phoneNumberError.text = errorMessage
                phoneNumberError.isHidden = false
            } else {
                phoneNumberError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPhoneNumber(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "Phone number must contain only digits."
        }
        
        if value.count != 10 {
            return "Phone number must contain 10 digits."
        }
        return nil
    }
    
    //MARK: - Amount Validation
    
    @IBAction func amountChanged(_ sender: Any) {
        print("amount changed ...")
        if let amount = amountTF.text {
            //if field is left blank
            if amount == "" {
                amountError.text = "Required"
                amountError.isHidden = false
            } else {
                //if field has some value
                let amountDouble: Float? = Float(amount)
                if amountDouble == nil {
                    amountError.text = "Invalid Number"
                    amountError.isHidden = false
                } else {
                    amountError.isHidden = true
                }
            }
        }
        //to enable/ disable submit based on input received in amount field
        checkForValidForm()
    }
    
    //MARK: - enable/ disable submit button
    //validation before enabling submit button
    func checkForValidForm() {
        if emailError.isHidden && phoneNumberError.isHidden && passwordError.isHidden && amountError.isHidden {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    //MARK: - Submit button action
    
    @IBAction func submitAction(_ sender: Any) {
        resetForm()
    }
    
}

