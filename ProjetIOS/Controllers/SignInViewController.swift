//
//  SignInViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 10/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import CoreData

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var mailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientBackground()
        validateButton.isEnabled = false
    }
    
    private func updateView() {
        if mailAdressTextField.text?.count != 0 && usernameTextField.text?.count != 0 && password2TextField.text?.count != 0 && passwordTextField.text?.count != 0 {
            validateButton.isEnabled = true
        } else {
            validateButton.isEnabled = false
        }
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    private func fetchData() {
        users = User.users
    }
    
    private func didContainUsername(username : String) -> Bool {
        var exist : Bool = false
        var i : Int = 0
        while i<users.count {
            if users[i].username == username {
                exist = true
            }
            i+=1
        }
        return exist
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTextField.resignFirstResponder()
        mailAdressTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        password2TextField.resignFirstResponder()
    }
    
    private func segueShowInitialView() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func createNewUser(mailAddress : String, username : String, password : String) {
        let context = AppDelegate.viewContext
        let newUser = User(context: context)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(mailAddress, forKey: "mailAddress")
        newUser.setValue("person.circle.fill", forKey: "picture")
        do {
            try context.save()
            print("Context saved !")
        } catch {
            print("Error impossible to save context !")
        }
        fetchData()
    }
    
    private func didContainMail(mailAddress : String) -> Bool {
        var exist : Bool = false
        var i : Int = 0
        while i<users.count {
            if users[i].mailAddress == mailAddress {
                exist = true
            }
            i+=1
        }
        return exist
    }
    
    @IBAction func mailATFChanged() {
        updateView()
    }
    
    @IBAction func usernameTFChanged() {
        updateView()
    }
    
    @IBAction func passwordTFChanged() {
        updateView()
    }
    
    @IBAction func password2TFChanged() {
        updateView()
    }
    
    @IBAction func crossOnClick() {
        mailAdressTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        password2TextField.text = ""
    }
    
    @IBAction func validateOnClick() {
        fetchData()
        if !mailAdressTextField.text!.contains("@") {
            print("Ce n'est pas une adresse mail valide")
        } else if !(passwordTextField.text!.contains("0")||passwordTextField.text!.contains("1")||passwordTextField.text!.contains("2")||passwordTextField.text!.contains("3")||passwordTextField.text!.contains("4")||passwordTextField.text!.contains("5")||passwordTextField.text!.contains("6")||passwordTextField.text!.contains("7")||passwordTextField.text!.contains("8")||passwordTextField.text!.contains("9")){
            print("Le mot de passe doit contenir au moins un chiffre")
        } else if passwordTextField.text != password2TextField.text {
            print("Les mots de passe ne correspondent pas")
        } else if didContainMail(mailAddress: mailAdressTextField.text!){
            print("Cette adresse mail est déjà utilisée")
        } else if didContainUsername(username: usernameTextField.text!){
            print("Ce nom d'utilisateur est déjà utilisé")
        } else {
            createNewUser(mailAddress: mailAdressTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!)
            segueShowInitialView()
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
