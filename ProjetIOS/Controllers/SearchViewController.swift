//
//  SearchViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 04/01/2020.
//  Copyright © 2020 Florian Bucheron. All rights reserved.
//

import UIKit
import CoreData
import AVKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UICollectionViewDelegateFlowLayout, Refresh {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var titleTrackButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var titleTrackLabel: UILabel!
    
    let cellID = "cellID"
    
    var itemName : [NSManagedObject] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        navigationItem.title = "Search"
        setCollectionView()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshPage()
    }
    
    func refreshPage() {
        setupTrackSingle()
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = itemName[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchCollectionCell
        if object.entity.name == "Single" {
            cell.textLabel.text = "\(object.value(forKey: "titleSingle") as! String) - Single by \((object as! Single).artist!.name!)"
            if (object as! Single).album != nil {
                cell.imageView.image = UIImage(named: (object as! Single).album!.image!)
            } else {
                cell.imageView.image = UIImage(named: (object as! Single).artist!.image!)
            }
        }
        if object.entity.name == "Concert" {
            cell.textLabel.text = "\(object.value(forKey: "titleConcert") as! String) - Concert in \((object as! Concert).locationCity!)"
            cell.imageView.image = UIImage(named: (object as! Concert).image!)
        }
        if object.entity.name == "Album" {
            cell.textLabel.text = "\(object.value(forKey: "titleAlbum") as! String) - Album"
            cell.imageView.image = UIImage(named: (object as! Album).image!)
        }
        if object.entity.name == "Artist" {
            cell.textLabel.text = "\(object.value(forKey: "name") as! String) - Artist"
            cell.imageView.image = UIImage(named: (object as! Artist).image!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch itemName[indexPath.item].entity.name {
        case "Single":
            let single = itemName[indexPath.item] as! Single
            let item = Item()
            item.name1 = single.artist?.name
            item.name2 = single.titleSingle
            item.video = single.video
            item.lyrics = single.lyrics
            item.category = "Single"
            if single.album != nil {
                item.imageName = single.album?.image
            } else {
                item.imageName = single.artist?.image
            }
            segueShowSingle(item: item)
        case "Concert":
            let concert = itemName[indexPath.item] as! Concert
            let item = Item()
            item.name1 = concert.artist?.name
            item.name2 = concert.titleConcert
            item.date = concert.date
            item.location = concert.location!+", "+concert.locationCity!
            item.category = "Concert"
            item.imageName = concert.image
            item.locationLat = concert.locationLat
            item.locationLgn = concert.locationLgn
            segueShowConcert(item: item)
        case "Album":
            let album = itemName[indexPath.item] as! Album
            let item = Item()
            item.name1 = album.artist?.name
            item.name2 = album.titleAlbum
            item.category = "Album"
            item.imageName = album.image
            segueShowAlbum(item: item)
        case "Artist":
            let artist = itemName[indexPath.item] as! Artist
            let item = Item()
            item.name1 = artist.name
            item.name2 = ""
            item.category = "Artist"
            item.imageName = artist.image
            item.ranking = artist.topArtist
            segueShowArtist(item: item)
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
        mySingleController.queueSingle = Single.singleFromName(singleName: item.name2!)
        navigationController?.pushViewController(mySingleController, animated: true)
        //        present(mySingleController, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar : UISearchBar, textDidChange searchText : String) {
        itemName.removeAll()
        var tableNSObject : [NSManagedObject] = []
        if searchText != "" {
            var predicate : NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
            let context = AppDelegate.viewContext
            var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Artist")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data artist")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "titleAlbum contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data album")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "artist.name contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data album")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "titleSingle contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Single")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data single")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "artist.name contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Single")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data single")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "album.titleAlbum contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Single")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data single")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            
            predicate = NSPredicate(format: "titleConcert contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Concert")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data concert")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "artist.name contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Concert")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data concert")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            predicate = NSPredicate(format: "locationCity contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Concert")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data concert")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
            
        }
        collectionView.reloadData()
    }
    
    func segueShowSingle2(item : Item) {
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
    
    @IBAction func singleTrackButtonOnClick() {
        if let single : Single = (UIApplication.shared.delegate as! AppDelegate).singleInTrack {
            segueShowSingle2(item: createItem(single: single))
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
}

class SearchCollectionCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let textLabel : UILabel = {
        let tv = UILabel()
        tv.textAlignment = .left
        tv.textColor = .white
        tv.font = .boldSystemFont(ofSize: 15)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(textLabel)
        imageView.frame = CGRect(x: 5, y: 0, width: frame.height, height: frame.height)
        textLabel.frame = CGRect(x: 80, y: 0, width: frame.width - 80, height: frame.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

