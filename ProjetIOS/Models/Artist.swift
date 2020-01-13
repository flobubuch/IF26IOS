//
//  Artist.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class Artist: NSManagedObject {
    
    static var allArtist : [Artist] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Artist> = Artist.fetchRequest()
        guard let allArtists = try? context.fetch(fetchRequest) else {
            return []
        }
        return allArtists
    }
    
    static var likeArtist : [Artist] {          //ATTENTION
        var artists : [Artist] = []
        for artist in allArtist {
            if (artist.users?.contains(User.actualUser.first!))! {
                artists.append(artist)
            }
        }
        return artists
    }
    
    static func artistFromName(artistName : String) -> [Artist] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Artist> = Artist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", artistName)
        guard let artists = try? context.fetch(fetchRequest) else {
            return []
        }
        return artists
    }
    
    static var topArtist : [Artist] {          //ATTENTION
        var artists : [Artist] = []
        //            if artist.topArtist == 1 || artist.topArtist == 2 || artist.topArtist == 3{
        //                artists.append(artist)
        //            }
        for artist in allArtist {
            if artist.topArtist == 2 {
                artists.append(artist)
            }
        }
        for artist in allArtist {
            if artist.topArtist == 1 {
                artists.append(artist)
            }
        }
        for artist in allArtist {
            if artist.topArtist == 3 {
                artists.append(artist)
            }
        }
        return artists
    }
}
