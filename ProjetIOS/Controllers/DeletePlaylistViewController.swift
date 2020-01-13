//
//  DeletePlaylistViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 02/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit

class DeletePlaylistViewController: UIViewController {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var viewController : ProfileSceneController?
    var namePlaylist : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupPopView()
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = gradientView.frame
        gradientView.layer.addSublayer(newLayer)
    }
    
    private func setupPopView() {
           popView.layer.cornerRadius = 10
           popView.layer.masksToBounds = true
           gradientView.layer.cornerRadius = 10
           gradientView.layer.masksToBounds = true
       }
    
    private func setupLabel() {
        label.text = "Are you sure to erase the playlist \(namePlaylist!) ?"
    }
    
    @IBAction func continueOnClick() {
        if namePlaylist != "Favorite" {
            deleteFromDatabase()
            viewController?.refreshPage()
            viewController?.showToast(messageToast: "Playlist effacée !")
        } else {
            viewController?.showToast(messageToast: "Vous ne pouvez pas supprimer Favorite")
        }
        segue()
    }
    
    private func deleteFromDatabase() {
        let context = AppDelegate.viewContext
        let playlistToDelete = Playlist.playlistFromName(playlistName: namePlaylist!).first!
        User.actualUser.first!.removeFromPlaylists(playlistToDelete)
        context.delete(playlistToDelete)
        do {
            try context.save()
            print("Context saved !")
        } catch {
            print("Error impossible to save context !")
        }
    }

    @IBAction func cancelOnClick() {
        segue()
    }
    
    private func segue() {
        dismiss(animated: true, completion: nil)
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
