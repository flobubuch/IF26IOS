//
//  ViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 10/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {}
    var users : [User] = []
    var playlists : [Playlist] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientBackground()
        updateView()
        PrepopulateRoot.makeRoot()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Login", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cleanTextFields()
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    private func cleanTextFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func fetchDataUser() {
        users = User.users
    }
    
    private func fetchDataPlaylist() {
        playlists = Playlist.playlistOfActualUser
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func makeFavorite(){
        print("Make favorite launch")
        print("j'ai changé ici")
        fetchDataPlaylist()
        if(!didContainFavorite()){
            print("la playlist favorite n'existe pas")
            let context = AppDelegate.viewContext
            let newPlaylistFavorite = Playlist(context: context)
            newPlaylistFavorite.setValue("like", forKey: "logoName")
            newPlaylistFavorite.setValue("Favorite", forKey: "name")
            print("actuel utilisateur")
            newPlaylistFavorite.user = User.actualUser.first!
            
            print("actuel utilisateur : \(newPlaylistFavorite.user!)")
            print(newPlaylistFavorite.user?.username as Any)
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
            fetchDataPlaylist()
        } else {
            print("La playlist favorite existe")
        }
    }
    
    private func didContainFavorite() -> Bool {
        var exist : Bool = false
        var i : Int = 0
        while i<playlists.count {
            if playlists[i].name == "Favorite" {
                exist = true
            }
            i+=1
        }
        return exist
    }
    
    private func updateView() {
        if usernameTextField.text?.count != 0 && passwordTextField.text?.count != 0 {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }
    
    private func segueShowTabBar() {
        print("segue show")
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let myTabBarViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MyTabBarController") as? MyTabBarController else {
            print("Couldn't find the view controller")
            return
        }
        navigationController?.pushViewController(myTabBarViewController, animated: true)
        print("on a push")
//        present(myTabBarViewController, animated: true, completion: nil)
    }
    
    private func showToast(messageToast : String) {
        let label = PaddingLabel()
        label.frame = CGRect(x: 0, y: view.frame.height-100, width: view.frame.width-50, height: 0)
        label.text = messageToast
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = #colorLiteral(red: 0.400228709, green: 0.4003006816, blue: 0.400219202, alpha: 1)
        label.numberOfLines = 0
        label.alpha = 1.0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.frame.origin.x = (view.frame.width/2)-(label.frame.width/2)
        self.view.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {label.alpha = 0.0}) {(isCompleted) in
            label.removeFromSuperview()
        }
    }
    
    @IBAction func usernameTFChanged() {
        updateView()
    }
    
    @IBAction func passwordTFChanged() {
        updateView()
    }
    
    @IBAction func logInOnClick() {
        var userSession : User?
        fetchDataUser()
        for user in users {
            if (usernameTextField.text == user.username || usernameTextField.text == user.mailAddress) && passwordTextField.text == user.password {
                userSession = user
                SettingUserDefaults.userNameConnected = user.username!
                print("Trouvé !")
            }
        }
        if userSession != nil {
            print("User found")
            PrepopulateFavorite.makeFavorite()
            segueShowTabBar()
        } else {
            print("Your account doesn't exist")
            showToast(messageToast: "Your account doesn't exist")
        }
    }
}

