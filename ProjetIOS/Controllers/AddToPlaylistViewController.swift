//
//  AddToPlaylistViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 09/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit

class AddToPlaylistViewController: UIViewController {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var collectionView: PlaylistToAddCollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    var singleName : String?
    var viewController : SingleViewController?
    
    
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
        layout.scrollDirection = .vertical
        let playAddCollectionView = PlaylistToAddCollectionView(frame: .zero, collectionViewLayout: layout)
        playAddCollectionView.backgroundColor = .clear
        playAddCollectionView.listPlaylists = Playlist.playlistOfActualUser
        playAddCollectionView.viewController = self
        collectionView.backgroundColor = .clear
        collectionView.addSubview(playAddCollectionView)
        
        playAddCollectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    @IBAction func backButtonOnClick() {
        segue()
    }
    
    private func segue() {
        dismiss(animated: false, completion: nil)
    }
    
    func registerInPlaylist(playlist : Playlist) {
        let single = Single.singleFromName(singleName: singleName!).first!
        if !(playlist.singles?.contains(single))! {
             let context = AppDelegate.viewContext
                   single.addToPlaylists(playlist)
                   do {
                       try context.save()
                       print("Context saved !")
                   } catch {
                       print("Error impossible to save context !")
                   }
                   viewController?.updateLike()
                   viewController?.showToast(messageToast: "titre ajouté dans la playlist \(playlist.name!)")
        } else {
            viewController?.showToast(messageToast: "le titre est déjà dans la playlist \(playlist.name!)")
        }
       segue()
    }
    
}
