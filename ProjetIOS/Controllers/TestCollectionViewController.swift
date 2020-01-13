//
//  TestCollectionViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 14/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TestCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Refresh {
    @IBOutlet weak var myView: UIView!
    private let cellID = "cellID"
    private let longCellID = "longCellID"
    var appCategories : [AppCategoryHome]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
        collectionView?.register(CategoryCellHome.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(LongCategoryCell.self, forCellWithReuseIdentifier: longCellID)
        appCategories = AppCategoryHome.sampleAppCategoriesHome()
        navigationItem.title = "Home"
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: longCellID, for: indexPath) as! LongCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            //cell.testCollectionViewController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCellHome
        cell.appCategory = appCategories?[indexPath.item]
        //cell.testCollectionViewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 3 {
            return CGSize(width: view.frame.width,height: 335)
        }
        return CGSize(width: view.frame.width, height: 230)
    }
    
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
        case "CreatePlaylist":
            segueCreatePlaylist()
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
    
    func segueCreatePlaylist() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                guard let myFirstPopUp = mainStoryBoard.instantiateViewController(withIdentifier: "myFirstPopUpID") as? PopUpPlaylistViewController else {
                    print("Couldn't find the view controller")
                    return
                }
        myFirstPopUp.viewController = self
                present(myFirstPopUp, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        appCategories = AppCategoryHome.sampleAppCategoriesHome()
        refreshPage()
    }
    
    func refreshPage() {
        appCategories = AppCategoryHome.sampleAppCategoriesHome()
        var indexPathTable : [IndexPath] = []
//        for i in 0...(Playlist.playlistOfActualUser.count+1) {
//            let indexPath = IndexPath(item: i, section: 0)
//            indexPathTable.append(indexPath)
//        }

        let indexPath = IndexPath(item: 0, section: 0)
        indexPathTable.append(indexPath)
        collectionView?.reloadItems(at: indexPathTable)
    }
}

class LongCategoryCell: CategoryCellHome{
    
    private let longAppCellID = "longAppCellID"
    override func setupViews() {
        super.setupViews()
        itemCollectionView.register(LongAppCell.self, forCellWithReuseIdentifier: longAppCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: longAppCellID, for: indexPath) as! ItemCell
        cell.item = appCategory?.items?[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 121, height: frame.height - 32)
    }
    
    private class LongAppCell : ItemCell {
        
        override var item: Item? {
            didSet{
                nameLabel.text = item?.name1
                nameLabel.font = UIFont.systemFont(ofSize: 14)
                imageView.image = UIImage(named: (item?.imageName)!)
                switch item?.ranking {
                case 1:
                    imageViewPodium.image = UIImage(systemName: "1.circle.fill")
                    imageViewPodium.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                case 2:
                    imageViewPodium.image = UIImage(systemName: "2.circle.fill")
                    imageViewPodium.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                case 3:
                    imageViewPodium.image = UIImage(systemName: "3.circle.fill")
                    imageViewPodium.tintColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                default:
                    break
                }
            }
        }
        
        let imageViewPodium : UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "concertstade")
            iv.contentMode = .scaleAspectFit
            iv.layer.cornerRadius = 30
            iv.layer.masksToBounds = true
            return iv
        }()
        
         override func setupViews() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            imageViewPodium.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addSubview(nameLabel)
            addSubview(imageViewPodium)
            imageView.contentMode = .scaleAspectFill
            nameLabel.textAlignment = .center
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageView]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageViewPodium]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(200)]-5-[v1(20)]-5-[v2(50)]-14-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageView, "v1" : nameLabel, "v2" : imageViewPodium]))
        }
    }
}


