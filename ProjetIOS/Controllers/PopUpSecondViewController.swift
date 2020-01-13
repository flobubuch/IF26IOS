//
//  PopUpSecondViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 01/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit

class PopUpSecondViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imageCollectionView: CreatePlaylistCollectionView!
    
    var viewController : Refresh?
    var playlistName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopView()
        setupGradient()
        setupCollectionView()
    }
    
    private func setupGradient() {
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
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let createPlaylistCollectionView = CreatePlaylistCollectionView(frame: .zero, collectionViewLayout: layout)
        createPlaylistCollectionView.backgroundColor = .clear
        createPlaylistCollectionView.viewController = self
        imageCollectionView.backgroundColor = .clear
        imageCollectionView.addSubview(createPlaylistCollectionView)
        
        createPlaylistCollectionView.frame = CGRect(x: 0, y: 0, width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
        
    }
    
    @IBAction func cancelOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    private func segue() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    func registerPlaylist(imageName : String) {
        let context = AppDelegate.viewContext
        let newPlaylist = Playlist(context: context)
        newPlaylist.setValue(imageName, forKey: "logoName")
        newPlaylist.setValue(playlistName, forKey: "name")
        newPlaylist.user = User.actualUser.first
        do {
            try context.save()
            print("Context saved !")
        } catch {
            print("Error impossible to save context !")
        }
        viewController?.refreshPage()
        segue()
    }
    
}
