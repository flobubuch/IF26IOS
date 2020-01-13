//
//  Concert.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class Concert: NSManagedObject {
    
    static var allConcerts : [Concert] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Concert> = Concert.fetchRequest()
        guard let concerts = try? context.fetch(fetchRequest) else {
            return []
        }
        return concerts
    }
    
    static func concertFromArtist(artistName : String)->[Concert] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<Concert> = Concert.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "artist.name == %@", artistName)
        guard let concerts = try? context.fetch(fetchRequest) else {
            return []
        }
        return concerts
    }
    
    static var newConcert : [Concert] {
        var concerts : [Concert] = []
        for concert in allConcerts {
            if concert.isNew {
                concerts.append(concert)
            }
        }
        return concerts
    }
    
}
