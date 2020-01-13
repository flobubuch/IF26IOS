//
//  ArtistViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 21/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameResultLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var ongletCollectionView: CollectionViewArtistPage!
    @IBOutlet weak var viewBar: MenuBarArtist!
    
    var cv : CollectionViewArtistPage?
    var menuBarArtist : MenuBarArtist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        setItemProperties()
        setupMenuBar()
        navigationItem.title = "Artist"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshPage()
    }
    
    func refreshPage() {
        setupLike()
        cv?.removeFromSuperview()
        setupOngletCollectionView()
        menuBarArtist?.removeFromSuperview()
        setupMenuBar()
        menuBarArtist?.selectItem0()
        menuBarArtist?.horizontalBarLeftAnchorConstraint?.constant = 0
    }
    
    private func setupLike() {
        if (User.actualUser.first?.likeArtists?.contains(Artist.artistFromName(artistName: item!.name1!).first!))! {
            followButton.setTitle("UNFOLLOW", for: .normal)
        } else {
            followButton.setTitle("FOLLOW", for: .normal)
        }
    }
    
    func fetchAlbums() -> [Album] { //attention
        return Album.albumFromArtist(artistName: item!.name1!)
    }
    
    func fetchSingles() -> [Single] { //attention
        return Single.singleFromArtist(artistName: item!.name1!)
    }
    
    func fetchBio() -> String { //attention
        return Artist.artistFromName(artistName: item!.name1!).first!.bio!
    }
    
    private func setupOngletCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = CollectionViewArtistPage(frame: .zero, collectionViewLayout: layout)
        self.cv = cv
        cv.backgroundColor = .clear
        cv.menuBar = menuBar
        cv.menuBar?.collectionViewPage = cv
        cv.listAlbums = fetchAlbums()
        cv.listSingles = fetchSingles()
        cv.bio = fetchBio()
        cv.viewController = self
        ongletCollectionView.addSubview(cv)
        ongletCollectionView.backgroundColor = .clear
        cv.isPagingEnabled = true
        
        cv.frame = CGRect(x: 0, y: 0, width: ongletCollectionView.frame.width, height: ongletCollectionView.frame.height)
    }
    
    
    private func setupMenuBar() {
        menuBarArtist = menuBar
        viewBar.addSubview(menuBarArtist!)
        viewBar.addSubview(menuBarArtist!.collectionView)
        menuBarArtist!.frame = CGRect(x: 0, y: 0, width: viewBar.frame.width, height: viewBar.frame.height)
        menuBarArtist?.collectionView.frame = CGRect(x: 0, y: 0, width: viewBar.frame.width, height: viewBar.frame.height)
    }
    
    
    let menuBar : MenuBarArtist = {
        let mb = MenuBarArtist()
        return mb
    }()
    
    var item : Item?
    
    private func setItemProperties() {
        imageView.image = UIImage(named: item!.imageName!)
        imageView.contentMode = .scaleToFill
        nameResultLabel.text = item?.name1
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    @IBAction func followOnClick() {
        if followButton.titleLabel?.text == "FOLLOW" {
            followButton.setTitle("UNFOLLOW", for: .normal)
            let context = AppDelegate.viewContext
            User.actualUser.first!.addToLikeArtists(Artist.artistFromName(artistName: item!.name1!).first!)
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
            
        } else {
            followButton.setTitle("FOLLOW", for: .normal)
            let context = AppDelegate.viewContext
            User.actualUser.first!.removeFromLikeArtists(Artist.artistFromName(artistName: item!.name1!).first!)
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
        }
    }
    
    func segueShowSingle(item : Item) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mySingleController = mainStoryBoard.instantiateViewController(withIdentifier: "mySingleController") as? SingleViewController else {
            print("Couldn't find the view controller")
            return
        }
        mySingleController.item = item
        mySingleController.queueSingle = Single.singleFromArtist(artistName: item.name1!)
        print("ON PASSE ICI SEGUE SINGLE ARTIST")
        print(Single.singleFromArtist(artistName: item.name1!).count)
        navigationController?.pushViewController(mySingleController, animated: true)
        //        present(myPlaylistController, animated: true, completion: nil)
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
    
}
