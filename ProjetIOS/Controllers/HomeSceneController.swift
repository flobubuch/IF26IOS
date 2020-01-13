//
//  HomeSceneController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 11/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import AVKit

class HomeSceneController: UIViewController, Refresh {
    
    @IBOutlet weak var singleTrackButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var titleTrack: UILabel!
    @IBOutlet weak var viewTrack: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myCollectionView: HomeCollectionView!
    @IBOutlet weak var heartButton: UIButton!
    var collectionView : HomeCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let homeCollectionView = HomeCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView = homeCollectionView
        collectionView?.appCategories = AppCategoryHome.sampleAppCategoriesHome()
        collectionView?.viewController = self
        collectionView?.backgroundColor = .clear
        myCollectionView.addSubview(collectionView!)
        myCollectionView.backgroundColor = .clear
        
        collectionView?.frame = CGRect(x: 0, y: 0, width: myCollectionView.frame.width, height: myCollectionView.frame.height)
        
        
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
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
        refreshPage()
    }
    
    func refreshPage() {
        collectionView?.removeFromSuperview()
        setupCollectionView()
        setupTrackSingle()
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
            titleTrack.text = "\((UIApplication.shared.delegate as! AppDelegate).singleInTrack!.titleSingle!) - \((UIApplication.shared.delegate as! AppDelegate).singleInTrack!.artist!.name!)"
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
