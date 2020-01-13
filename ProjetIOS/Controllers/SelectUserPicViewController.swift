//
//  SelectUserPicViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 03/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit

class SelectUserPicViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewController : Refresh?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopView()
        setupGradient()
        setupCollectionView()
    }
    
    @IBAction func backOnClick() {
        segue()
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
        let changePhotoCollectionView = ChangePhotoCollectionView(frame: .zero, collectionViewLayout: layout)
        changePhotoCollectionView.backgroundColor = .clear
        changePhotoCollectionView.viewController = self
        collectionView.backgroundColor = .clear
        collectionView.addSubview(changePhotoCollectionView)
        
        changePhotoCollectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    private func segue() {
        dismiss(animated: false, completion: nil)
    }
    
//    func registerPlaylist(imageName : String) {
//        let context = AppDelegate.viewContext
//        let newPlaylist = Playlist(context: context)
//        newPlaylist.setValue(imageName, forKey: "logoName")
//        newPlaylist.setValue(playlistName, forKey: "name")
//        newPlaylist.user = User.actualUser.first
//        do {
//            try context.save()
//            print("Context saved !")
//        } catch {
//            print("Error impossible to save context !")
//        }
//        viewController?.refreshPage()
//        segue()
//    }
    
    func changeUserPhoto(imageName : String?) {
        let context = AppDelegate.viewContext
        User.actualUser.first!.picture = imageName
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



