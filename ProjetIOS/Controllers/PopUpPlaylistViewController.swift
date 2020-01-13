//
//  PopUpPlaylistViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 01/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit

class PopUpPlaylistViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameTf: UITextField!
    
    var viewController : Refresh?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopView()
        refreshButton()
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = viewGradient.frame
        viewGradient.layer.addSublayer(newLayer)
    }
    
    private func refreshButton() {
        if nameTf.text?.count == 0 {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
        }
    }
    
    private func setupPopView() {
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        viewGradient.layer.cornerRadius = 10
        viewGradient.layer.masksToBounds = true
        
    }
    
    @IBAction func nameTfChanged() {
        refreshButton()
    }
    
    @IBAction func cancelOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueOnClick() {
        if !didContainPlaylist(namePlaylist: nameTf!.text!) {
            let secondPopUp = storyboard?.instantiateViewController(identifier: "mySecondPopUpID") as! PopUpSecondViewController
            secondPopUp.playlistName = nameTf.text
            secondPopUp.viewController = viewController
            present(secondPopUp, animated: true, completion: nil)
        } else {
            showToast(messageToast: "Ce nom existe déjà")
        }
        
    }
    
    private func didContainPlaylist(namePlaylist : String) -> Bool {
        var exist : Bool = false
        let playlists = Playlist.playlistOfActualUser
        var i : Int = 0
        while i<playlists.count {
            if playlists[i].name == namePlaylist {
                exist = true
                break
            }
            i+=1
        }
        return exist
    }
    
    private func showToast(messageToast : String) {
        let label = PaddingLabel()
        label.frame = CGRect(x: 0, y: popView.frame.height-100, width: popView.frame.width-25, height: 0)
        label.text = messageToast
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = #colorLiteral(red: 0.400228709, green: 0.4003006816, blue: 0.400219202, alpha: 1)
        label.numberOfLines = 0
        label.alpha = 1.0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.frame.origin.x = (popView.frame.width/2)-(label.frame.width/2)
        self.popView.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {label.alpha = 0.0}) {(isCompleted) in
            label.removeFromSuperview()
        }
    }
    
    
}
