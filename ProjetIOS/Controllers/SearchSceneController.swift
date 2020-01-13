//
//  SearchSceneController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 11/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import CoreData

class SearchSceneController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "cellID"
    
    var itemName : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        navigationItem.title = "Search"
        setTableView()
        searchBar.delegate = self
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = itemName[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if object.entity.name == "Single" {
            cell.textLabel?.text = object.value(forKey: "titleSingle") as? String
        }
        if object.entity.name == "Concert" {
            cell.textLabel?.text = object.value(forKey: "titleConcert") as? String
        }
        if object.entity.name == "Album" {
            cell.textLabel?.text = object.value(forKey: "titleAlbum") as? String
        }
        if object.entity.name == "Artist" {
            cell.textLabel?.text = object.value(forKey: "name") as? String
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch itemName[indexPath.item].entity.name {
        case "Single":
            let single = itemName[indexPath.item] as! Single
            let item = Item()
            item.name1 = single.artist?.name
            item.name2 = single.titleSingle
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
            navigationController?.pushViewController(mySingleController, animated: true)
    //        present(mySingleController, animated: true, completion: nil)
        }
    
    
    
    func searchBar(_ searchBar : UISearchBar, textDidChange searchText : String) {
        itemName.removeAll()
        var tableNSObject : [NSManagedObject] = []
        if searchText != "" {
            var predicate : NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "titleSingle contains[c] '\(searchText)'")
            let context = AppDelegate.viewContext
            var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Single")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data single")
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
            predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Artist")
            fetchRequest.predicate = predicate
            do {
                tableNSObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
                print("Could no get search data artist")
            }
            itemName.append(contentsOf: tableNSObject)
            tableNSObject.removeAll()
        }
        tableView.reloadData()
    }
}
