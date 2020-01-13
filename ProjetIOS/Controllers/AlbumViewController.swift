//
//  AlbumViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 21/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titlesLabel: UILabel!
    @IBOutlet weak var nameResultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: CollectionViewAlbum!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        setItemProperties()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLike()
    }
    
    private func setupLike() {
        if (User.actualUser.first?.likeAlbums?.contains(Album.albumFromName(albumName: item!.name2!).first!))! {
            likeButton.setTitle("UNLIKE", for: .normal)
        } else {
            likeButton.setTitle("LIKE", for: .normal)
        }
    }
    
    var item : Item?
    
    private func setItemProperties() {
        imageView.image = UIImage(named: item!.imageName!)
        imageView.contentMode = .scaleToFill
        nameResultLabel.text = item?.name2
        navigationItem.title = "Album"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let cv = CollectionViewAlbum(frame: .zero, collectionViewLayout: layout)
        cv.listSingles = Single.singleFromAlbum(albumName: item!.name2!)
        cv.viewController = self
        cv.backgroundColor = .clear
        collectionView.addSubview(cv)
        collectionView.backgroundColor = .clear
        
        cv.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    func segueShowSingle(item : Item) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mySingleController = mainStoryBoard.instantiateViewController(withIdentifier: "mySingleController") as? SingleViewController else {
            print("Couldn't find the view controller")
            return
        }
        mySingleController.item = item
        mySingleController.queueSingle = Single.singleFromAlbum(albumName: self.item!.name2!)
        navigationController?.pushViewController(mySingleController, animated: true)
        //        present(myPlaylistController, animated: true, completion: nil)
    }
    
    @IBAction func likeOnClick() {
        if likeButton.titleLabel?.text == "LIKE" {
            likeButton.setTitle("UNLIKE", for: .normal)
            let context = AppDelegate.viewContext
            User.actualUser.first!.addToLikeAlbums(Album.albumFromName(albumName: item!.name2!).first!)
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
        } else {
            likeButton.setTitle("LIKE", for: .normal)
            let context = AppDelegate.viewContext
            User.actualUser.first!.removeFromLikeAlbums(Album.albumFromName(albumName: item!.name2!).first!)
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
        }
    }
}
