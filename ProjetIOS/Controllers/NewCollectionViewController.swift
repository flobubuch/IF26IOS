//
//  NewCollectionViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 22/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var myView: UIView!
    
   private let cellID = "cellID"
        private let longCellID = "longCellID"
        var appCategories : [AppCategoryNew]?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let newLayer = CAGradientLayer()
            let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
            let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
            newLayer.colors = [topColor, botColor]
            newLayer.frame = view.frame
            myView.layer.addSublayer(newLayer)
            collectionView?.register(CategoryCellNew.self, forCellWithReuseIdentifier: cellID)
            collectionView?.register(LongCategoryCell.self, forCellWithReuseIdentifier: longCellID)
            appCategories = AppCategoryNew.sampleAppCategoriesNew()
            navigationItem.title = "New"
           
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let count = appCategories?.count {
                return count
            }
            return 0
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCellNew
            cell.appCategory = appCategories?[indexPath.item]
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width, height: 230)
        }
        
        /*override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("selected category")
            switch indexPath.item {
            case 0:
                segueShowPlaylist()
            case 1:
                segueShowConcert()
            case 2:
                segueShowAlbum()
            case 3:
                segueShowArtist()
            default:
                break
            }
        }*/
        
        func showDetailForApp(item : Item) {
            print("showdetailForAPp")
            print("category : \(item.category ?? "default1")")
            switch item.category {
            case "Playlist":
                segueShowPlaylist(item: item)
            case "Concert":
                segueShowConcert(item : item)
            case "Album":
                segueShowAlbum(item : item)
            case "Artist":
                segueShowArtist(item : item)
            case "Single":
                segueShowSingle(item: item)
            default:
                break
            }
        }
        
        func segueShowPlaylist(item : Item) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let myPlaylistController = mainStoryBoard.instantiateViewController(withIdentifier: "myPlaylistController") as? PlaylistViewController else {
                print("Couldn't find the view controller")
                return
            }
            myPlaylistController.item = item
            navigationController?.pushViewController(myPlaylistController, animated: true)
    //        present(myPlaylistController, animated: true, completion: nil)
        }
        
        func segueShowConcert(item : Item) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let myConcertController = mainStoryBoard.instantiateViewController(withIdentifier: "myConcertController") as? ConcertViewController else {
                print("Couldn't find the view controller")
                return
            }
            myConcertController.item = item
            navigationController?.pushViewController(myConcertController, animated: true)
    //        present(myConcertController, animated: true, completion: nil)
        }
        
        func segueShowArtist(item : Item) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let myArtistController = mainStoryBoard.instantiateViewController(withIdentifier: "myArtistController") as? ArtistViewController else {
                print("Couldn't find the view controller")
                return
            }
            myArtistController.item = item
            navigationController?.pushViewController(myArtistController, animated: true)
    //        present(myArtistController, animated: true, completion: nil)
        }
        
        func segueShowAlbum(item : Item) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let myAlbumController = mainStoryBoard.instantiateViewController(withIdentifier: "myAlbumController") as? AlbumViewController else {
                print("Couldn't find the view controller")
                return
            }
            myAlbumController.item = item
            navigationController?.pushViewController(myAlbumController, animated: true)
    //        present(myAlbumController, animated: true, completion: nil)
        }
        
        func segueShowSingle(item : Item) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let mySingleController = mainStoryBoard.instantiateViewController(withIdentifier: "mySingleController") as? SingleViewController else {
                print("Couldn't find the view controller")
                return
            }
            mySingleController.item = item
            mySingleController.queueSingle = Single.newSingle
            navigationController?.pushViewController(mySingleController, animated: true)
    //        present(mySingleController, animated: true, completion: nil)
        }
    }
