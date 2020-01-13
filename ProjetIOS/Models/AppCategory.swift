//
//  AppCategory.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 19/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppCategoryHome: NSObject {
    
    var name : String?
    var items : [Item]?
    
    static func sampleAppCategoriesHome() -> [AppCategoryHome] {
        let playlists = Playlist.playlistOfActualUser
        let concerts = Concert.allConcerts
        let albums = Album.allAlbum
        let artists = Artist.topArtist
        let playlistCategory = AppCategoryHome()
        playlistCategory.name = "MY PLAYLISTS"
        var playlistItems = [Item]()
        for playlist in playlists {
            let item = Item()
            item.name1 = playlist.name
            item.name2 = ""
            item.category = "Playlist"
            item.imageName = playlist.logoName
            playlistItems.append(item)
        }
        let item = Item()
        item.name1 = "Create Playlist"
        item.name2 = ""
        item.category = "CreatePlaylist"
        item.imageName = "add_to_playlist_icon"
        playlistItems.append(item)
        playlistCategory.items=playlistItems
        let concertCategory = AppCategoryHome()
        concertCategory.name = "NEAREST CONCERTS"
        var concertItems = [Item]()
        for concert in concerts {
            let item = Item()
            item.name1 = concert.artist?.name
            item.name2 = concert.titleConcert
            item.date = concert.date
            item.location = concert.location!+", "+concert.locationCity!
            item.category = "Concert"
            item.imageName = concert.image
            item.locationLat = concert.locationLat
            item.locationLgn = concert.locationLgn
            concertItems.append(item)
        }
        concertCategory.items=concertItems
        let albumCategory = AppCategoryHome()
        albumCategory.name = "RECOMMENDED ALBUMS"
        var albumItems = [Item]()
        for album in albums {
            let item = Item()
            item.name1 = album.artist?.name
            item.name2 = album.titleAlbum
            item.category = "Album"
            item.imageName = album.image
            albumItems.append(item)
        }
        albumCategory.items=albumItems
        let artistCategory = AppCategoryHome()
        artistCategory.name = "TOP WORLD"
        var artistItems = [Item]()
        for artist in artists {
            let item = Item()
            item.name1 = artist.name
            item.name2 = ""
            item.category = "Artist"
            item.imageName = artist.image
            item.ranking = artist.topArtist
            artistItems.append(item)
        }
        artistCategory.items=artistItems
        return [playlistCategory, concertCategory, albumCategory, artistCategory]
    }
}

class AppCategoryNew: NSObject {
    
    var name : String?
    var items : [Item]?
    
    static func sampleAppCategoriesNew() -> [AppCategoryNew] {
        let concerts = Concert.newConcert
        let albums = Album.newAlbum
        let singles = Single.newSingle
        let concertCategory = AppCategoryNew()
        concertCategory.name = "NEW CONCERTS"
        var concertItems = [Item]()
        for concert in concerts {
            let item = Item()
            item.name1 = concert.artist?.name
            item.name2 = concert.titleConcert
            item.date = concert.date
            item.location = concert.location!+", "+concert.locationCity!
            item.category = "Concert"
            item.imageName = concert.image
            item.locationLat = concert.locationLat
            item.locationLgn = concert.locationLgn
            concertItems.append(item)
        }
        concertCategory.items = concertItems
        let albumCategory = AppCategoryNew()
        albumCategory.name = "NEW ALBUMS"
        var albumItems = [Item]()
        for album in albums {
            let item = Item()
            item.name1 = album.artist?.name
            item.name2 = album.titleAlbum
            item.category = "Album"
            item.imageName = album.image
            albumItems.append(item)
        }
        albumCategory.items = albumItems
        let singleCategory = AppCategoryNew()
        singleCategory.name = "NEW SINGLES"
        var singleItems = [Item]()
        for single in singles {
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
            singleItems.append(item)
        }
        singleCategory.items = singleItems
        return [singleCategory, concertCategory, albumCategory]
    }
}

class Item: NSObject {
    
    var name1 : String?
    var name2 : String?
    var category : String?
    var imageName : String?
    var ranking : Int16?
    var date : String?
    var location : String?
    var locationLgn : Double?
    var locationLat : Double?
    var video : String?
    var lyrics : String?
    
}
