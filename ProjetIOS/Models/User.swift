//
//  User.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    static var users : [User] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        guard let allUsers = try? context.fetch(fetchRequest) else {
            return []
        }
        return allUsers
    }
    
    static var actualUser : [User] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", SettingUserDefaults.userNameConnected)
        guard let user = try? context.fetch(fetchRequest) else {
            return []
        }
        return user
    }
    
    static var rootUser : [User] {
        let context = AppDelegate.viewContext
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", "root")
        guard let user = try? context.fetch(fetchRequest) else {
            return []
        }
        return user
    }
}
