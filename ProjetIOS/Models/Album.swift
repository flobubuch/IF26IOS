//
//  Album.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class Album: NSManagedObject {
    static var allAlbum : [Album] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Album> = Album.fetchRequest()
        guard let allAlbums = try? context.fetch(fetchRequest) else {
            return []
        }
        return allAlbums
    }
    
    static var likeAlbums : [Album] {   //ATTENTION
        var allLikeAlbums : [Album] = []
        for album in allAlbum {
            if (album.users?.contains(User.actualUser.first!))! {
                allLikeAlbums.append(album)
            }
        }
        return allLikeAlbums
    }
    
    static func albumFromArtist(artistName : String)->[Album] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Album> = Album.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "artist.name == %@", artistName)
        guard let albums = try? context.fetch(fetchRequest) else {
            return []
        }
        return albums
    }
    
    static func albumFromName(albumName : String)->[Album] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Album> = Album.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "titleAlbum == %@", albumName)
        guard let albums = try? context.fetch(fetchRequest) else {
            return []
        }
        return albums
    }
    
    static var newAlbum : [Album] {
        var albums : [Album] = []
        for album in allAlbum {
            if album.isNew {
                albums.append(album)
            }
        }
        return albums
    }
    
}
