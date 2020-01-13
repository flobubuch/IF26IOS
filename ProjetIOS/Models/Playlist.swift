//
//  Playlist.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class Playlist : NSManagedObject {
    static var allPlaylists : [Playlist] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Playlist> = Playlist.fetchRequest()
        guard let playlists = try? context.fetch(fetchRequest) else {
            return []
        }
        return playlists
    }
    
    static var playlistOfActualUser : [Playlist] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Playlist> = Playlist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user.username == %@", SettingUserDefaults.userNameConnected)
        guard let playlists = try? context.fetch(fetchRequest) else {
            return []
        }
        return playlists
    }
    
    static func playlistFromName(playlistName : String) -> [Playlist] {
        var playlists : [Playlist] = []
        for playlist in playlistOfActualUser {
            if playlist.name == playlistName {
                playlists.append(playlist)
            }
        }
        return playlists
    }
    
    static var playlistFavorite : [Playlist] {
        var playlists : [Playlist] = []
        for playlist in playlistOfActualUser {
            if playlist.name == "Favorite" {
                playlists.append(playlist)
            }
        }
        return playlists
    }
}
