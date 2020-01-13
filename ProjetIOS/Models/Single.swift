//
//  Single.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class Single: NSManagedObject {
    
    static var allSingle : [Single] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Single> = Single.fetchRequest()
        guard let allSingles = try? context.fetch(fetchRequest) else {
            return []
        }
        return allSingles
    }
    
    static func singleFromPlaylist(playlistName : String) -> [Single] {      //ATTENTION
        var singlesOfPlaylistAndUser : [Single] = []
        var playlistOfUserRightName : Playlist?
        for playlist in Playlist.playlistOfActualUser {
            if playlist.name == playlistName {
                playlistOfUserRightName = playlist
            }
        }
        if playlistOfUserRightName != nil {
            for single in Single.allSingle {
                if (single.playlists?.contains(playlistOfUserRightName!))! {
                    singlesOfPlaylistAndUser.append(single)
                }
            }
            return singlesOfPlaylistAndUser
        } else {
            return []
        }
    }
    
    static var singleFromFavorite : [Single] {      //ATTENTION
        var singlesOfPlaylistAndUser : [Single] = []
        var playlistOfUserRightName : Playlist?
        for playlist in Playlist.playlistOfActualUser {
            if playlist.name == "Favorite" {
                playlistOfUserRightName = playlist
            }
        }
        if playlistOfUserRightName != nil {
            for single in Single.allSingle {
                if (single.playlists?.contains(playlistOfUserRightName!))! {
                    singlesOfPlaylistAndUser.append(single)
                }
            }
            return singlesOfPlaylistAndUser
        } else {
            return []
        }
    }
    
    static func singleFromAlbum(albumName : String)->[Single] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Single> = Single.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "album.titleAlbum == %@", albumName)
        guard let singles = try? context.fetch(fetchRequest) else {
            return []
        }
        return singles
    }
    
    static func singleFromArtist(artistName : String)->[Single] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Single> = Single.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "artist.name == %@", artistName)
        guard let singles = try? context.fetch(fetchRequest) else {
            return []
        }
        return singles
    }
    
    static func singleFromName(singleName : String)->[Single] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Single> = Single.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "titleSingle == %@", singleName)
        guard let singles = try? context.fetch(fetchRequest) else {
            return []
        }
        return singles
    }
    
    static var newSingle : [Single] {
        var singles : [Single] = []
        for single in allSingle {
            if single.isNew {
                singles.append(single)
            }
        }
        return singles
    }
}
