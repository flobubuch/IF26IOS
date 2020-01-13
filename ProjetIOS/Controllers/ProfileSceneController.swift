//
//  ProfileSceneController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 11/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import AVKit

class ProfileSceneController: UIViewController, Refresh {
    
    @IBOutlet weak var userPicture: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var viewBar: MenuBarProfile!
    @IBOutlet weak var ongletCollectionView: CollectionViewProfilePage!
    @IBOutlet weak var titleTrackLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var titleTrackButton: UIButton!
    
    var cv : CollectionViewProfilePage?
    var menuBarProfile : MenuBarProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        navigationItem.title = "Profile"
        setUserPic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshPage()
    }
    
    @IBAction func userPictureOnClick() {
        
        
    }
    
    private func setUserPic() {
        let imageName = User.actualUser.first!.picture!
        if imageName != "person.circle.fill" {
            userPicture.setBackgroundImage(UIImage(named: imageName), for: .normal)
            userPicture.setTitle("", for: .normal)
        }
        userPicture.layer.cornerRadius = 10
        userPicture.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCreatePlaylist" {
            let createVC = segue.destination as! PopUpPlaylistViewController
            createVC.viewController = self  // On passe la donnée via les propriétés
        }
        if segue.identifier == "mySelectPicture" {
            let selectVC = segue.destination as! SelectUserPicViewController
            selectVC.viewController = self  // On passe la donnée via les propriétés
        }
    }
    
    func refreshPage() {
        cv?.removeFromSuperview()
        setupOngletCollectionView()
        menuBarProfile?.removeFromSuperview()
        setupMenuBar()
        menuBarProfile?.selectItem0()
        menuBarProfile?.horizontalBarLeftAnchorConstraint?.constant = 0
        setUserPic()
        setupTrackSingle()
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    private func setupMenuBar() {
        menuBarProfile = menuBar
        viewBar.addSubview(menuBarProfile!)
        viewBar.addSubview(menuBarProfile!.collectionView)
        menuBarProfile!.frame = CGRect(x: 0, y: 0, width: viewBar.frame.width, height: viewBar.frame.height)
        menuBarProfile!.collectionView.frame = CGRect(x: 0, y: 0, width: viewBar.frame.width, height: viewBar.frame.height)
    }
    
    let menuBar : MenuBarProfile = {
        let mb = MenuBarProfile()
        return mb
    }()
    
    private func setupOngletCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = CollectionViewProfilePage(frame: .zero, collectionViewLayout: layout)
        self.cv = cv
        cv.backgroundColor = .clear
        cv.menuBar = menuBar
        cv.menuBar?.collectionViewPage = cv
        cv.viewController = self
        cv.listPlaylists = Playlist.playlistOfActualUser
        cv.listArtists = Artist.likeArtist
        cv.listAlbums = Album.likeAlbums
        ongletCollectionView.addSubview(cv)
        ongletCollectionView.backgroundColor = .clear
        cv.isPagingEnabled = true
        
        cv.frame = CGRect(x: 0, y: 0, width: ongletCollectionView.frame.width, height: ongletCollectionView.frame.height)
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
    
    func segueShowDeletePlaylist(playlistName : String) {
        let deletePlaylist = storyboard?.instantiateViewController(identifier: "myDeletePlaylist") as! DeletePlaylistViewController
        deletePlaylist.viewController = self
        deletePlaylist.namePlaylist = playlistName
        present(deletePlaylist, animated: true, completion: nil)
    }
    
    func showToast(messageToast : String) {
        let label = PaddingLabel()
        label.frame = CGRect(x: 0, y: view.frame.height-100, width: view.frame.width-25, height: 0)
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
    
    @IBAction func playPauseButtonOnClick() {
        if let avplayer : AVQueuePlayer = (UIApplication.shared.delegate as! AppDelegate).queuePlayer {
            if playPauseButton.backgroundImage(for: .normal) == UIImage(systemName: "play.fill") {
                playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                avplayer.play()
            } else {
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
                avplayer.pause()
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
        mySingleController.queueSingle = (UIApplication.shared.delegate as! AppDelegate).queueSingle
        mySingleController.videoPlayer = (UIApplication.shared.delegate as! AppDelegate).queuePlayer
        mySingleController.tableItemPlayer = (UIApplication.shared.delegate as! AppDelegate).tableItemPlayer
        navigationController?.pushViewController(mySingleController, animated: true)
        //        present(mySingleController, animated: true, completion: nil)
    }
    
    private func createItem(single : Single) -> Item {
        let item = Item()
        item.name1 = single.artist?.name
        item.name2 = single.titleSingle
        item.lyrics = single.lyrics
        item.video = single.video
        item.category = "Single"
        if single.album != nil {
            item.imageName = single.album?.image
        } else {
            item.imageName = single.artist?.image
        }
        return item
    }
    
    private func setupTrackSingle() {
        if let avplayer = (UIApplication.shared.delegate as! AppDelegate).queuePlayer {
            heartButton.isHidden = false
            playPauseButton.isHidden = false
            if avplayer.timeControlStatus == AVPlayer.TimeControlStatus.paused {
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            } else if avplayer.timeControlStatus == AVPlayer.TimeControlStatus.playing {
                playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
            if (Playlist.playlistFavorite.first?.singles?.contains((UIApplication.shared.delegate as! AppDelegate).singleInTrack!))! {
                heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
            titleTrackLabel.text = "\((UIApplication.shared.delegate as! AppDelegate).singleInTrack!.titleSingle!) - \((UIApplication.shared.delegate as! AppDelegate).singleInTrack!.artist!.name!)"
        } else {
            heartButton.isHidden = true
            playPauseButton.isHidden = true
        }
    }
    
    @IBAction func singleTrackButtonOnClick() {
        if let single : Single = (UIApplication.shared.delegate as! AppDelegate).singleInTrack {
            segueShowSingle(item: createItem(single: single))
        }
    }
    @IBAction func heartButtonOnClick() {
        if let avplayer : AVQueuePlayer = (UIApplication.shared.delegate as! AppDelegate).queuePlayer {
            if !(Playlist.playlistFavorite.first!.singles?.contains((UIApplication.shared.delegate as! AppDelegate).singleInTrack!))! {
                print("heart fill")
                heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                let context = AppDelegate.viewContext
                Playlist.playlistFavorite.first!.addToSingles((UIApplication.shared.delegate as! AppDelegate).singleInTrack!)
                do {
                    try context.save()
                    print("Context saved !")
                } catch {
                    print("Error impossible to save context !")
                }
                setupTrackSingle()
                
            } else {
                print("heart")
                heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                let context = AppDelegate.viewContext
                Playlist.playlistFavorite.first!.removeFromSingles((UIApplication.shared.delegate as! AppDelegate).singleInTrack!)
                do {
                    try context.save()
                    print("Context saved !")
                } catch {
                    print("Error impossible to save context !")
                }
                setupTrackSingle()
            }
        }
    }
}


