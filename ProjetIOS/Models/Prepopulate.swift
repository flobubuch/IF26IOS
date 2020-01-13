//
//  Prepopulate.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 19/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import CoreData

class PrepopulateRoot {
    
    static func makeRoot() {
        let users = User.users
        if(!didContainRoot(users: users)){
            let context = AppDelegate.viewContext
            
            //Root User
            let newUserRoot = User(context: context)
            newUserRoot.setValue("root", forKey: "username")
            newUserRoot.setValue("root", forKey: "password")
            newUserRoot.setValue("root@root.fr", forKey: "mailAddress")
            newUserRoot.setValue("person.circle.fill", forKey: "picture")
      
            //Artists
            let coldplay = Artist(context: context)
            coldplay.setValue("Coldplay", forKey: "name")
            coldplay.setValue("coldplay", forKey: "image")
            coldplay.setValue(0, forKey: "topArtist")
            coldplay.setValue("coldplay_bio", forKey: "bio")
            
            let linkin = Artist(context: context)
            linkin.setValue("Linkin Park", forKey: "name")
            linkin.setValue("linkinpark", forKey: "image")
            linkin.setValue(0, forKey: "topArtist")
            linkin.setValue("linkinpark_bio", forKey: "bio")
            
            let olivier = Artist(context: context)
            olivier.setValue("Oliver Francis", forKey: "name")
            olivier.setValue("olivierfrancis", forKey: "image")
            olivier.setValue(0, forKey: "topArtist")
            olivier.setValue("olivierfrancis_bio", forKey: "bio")
            
            let postmalone = Artist(context: context)
            postmalone.setValue("Post Malone", forKey: "name")
            postmalone.setValue("postmalone", forKey: "image")
            postmalone.setValue(2, forKey: "topArtist")
            postmalone.setValue("postmalone_bio", forKey: "bio")
            
            let ariana = Artist(context: context)
            ariana.setValue("Ariana Grande", forKey: "name")
            ariana.setValue("arianagrande", forKey: "image")
            ariana.setValue(1, forKey: "topArtist")
            ariana.setValue("arianagrande_bio", forKey: "bio")
            
            let vegedream = Artist(context: context)
            vegedream.setValue("Vegedream", forKey: "name")
            vegedream.setValue("vegedream", forKey: "image")
            vegedream.setValue(3, forKey: "topArtist")
            vegedream.setValue("vegedream_bio", forKey: "bio")
            
            //Album
            let hollywood = Album(context: context)
            hollywood.setValue(true, forKey: "isNew")
            hollywood.setValue("postmalone_album_hollywood", forKey: "image")
            hollywood.setValue("Hollywood's Bleeding", forKey: "titleAlbum")
            hollywood.artist = postmalone
            
            let beerpong = Album(context: context)
            beerpong.setValue(false, forKey: "isNew")
            beerpong.setValue("postmalone_album_beerpong", forKey: "image")
            beerpong.setValue("Beerpongs & Bentleys", forKey: "titleAlbum")
            beerpong.artist = postmalone
            
            let thankU = Album(context: context)
            thankU.setValue(true, forKey: "isNew")
            thankU.setValue("arianagrande_album_thank", forKey: "image")
            thankU.setValue("Thank U, Next", forKey: "titleAlbum")
            thankU.artist = ariana
            
            let sweetener = Album(context: context)
            sweetener.setValue(false, forKey: "isNew")
            sweetener.setValue("arianagrande_album_sweetener", forKey: "image")
            sweetener.setValue("Sweetener", forKey: "titleAlbum")
            sweetener.artist = ariana
            
            //Concert
            let concert1 = Concert(context: context)
            concert1.setValue("2019EuroTour", forKey: "titleConcert")
            concert1.setValue("22/02/2020", forKey: "date")
            concert1.setValue("Accordhotels arena", forKey: "location")
            concert1.setValue("Paris", forKey: "locationCity")
            concert1.setValue(true, forKey: "isNew")
            concert1.setValue("postmalone_paris_concert", forKey: "image")
            concert1.setValue(48.838599, forKey: "locationLat")
            concert1.setValue(2.378591, forKey: "locationLgn")
            concert1.artist = postmalone
            
            let concert2 = Concert(context: context)
            concert2.setValue("Sweetener World Tour", forKey: "titleConcert")
            concert2.setValue("22/02/2020", forKey: "date")
            concert2.setValue("The Forum", forKey: "location")
            concert2.setValue("Los Angeles", forKey: "locationCity")
            concert2.setValue(false, forKey: "isNew")
            concert2.setValue("arianagrande_concert", forKey: "image")
            concert2.setValue(33.958638, forKey: "locationLat")
            concert2.setValue(-118.341987, forKey: "locationLgn")
            concert2.artist = ariana
            
            let concert3 = Concert(context: context)
            concert3.setValue("Sweetener World Tour", forKey: "titleConcert")
            concert3.setValue("12/02/2020", forKey: "date")
            concert3.setValue("Barclays Center", forKey: "location")
            concert3.setValue("New York", forKey: "locationCity")
            concert3.setValue(false, forKey: "isNew")
            concert3.setValue("arianagrande_concert", forKey: "image")
            concert3.setValue(40.682853, forKey: "locationLat")
            concert3.setValue(-73.975392, forKey: "locationLgn")
            concert3.artist = ariana
            
            let concert4 = Concert(context: context)
            concert4.setValue("Game Over", forKey: "titleConcert")
            concert4.setValue("28/03/2020", forKey: "date")
            concert4.setValue("Zenith De Paris La Villette", forKey: "location")
            concert4.setValue("Paris", forKey: "locationCity")
            concert4.setValue(true, forKey: "isNew")
            concert4.setValue("vegedream_paris_concert", forKey: "image")
            concert4.setValue(48.894317, forKey: "locationLat")
            concert4.setValue(2.393186, forKey: "locationLgn")
            concert4.artist = vegedream
            
            let concert5 = Concert(context: context)
            concert5.setValue("Game Over", forKey: "titleConcert")
            concert5.setValue("28/04/2020", forKey: "date")
            concert5.setValue("L'amphithéâtre cité internationale", forKey: "location")
            concert5.setValue("Lyon", forKey: "locationCity")
            concert5.setValue(true, forKey: "isNew")
            concert5.setValue("vegedream_lyon_concert", forKey: "image")
            concert5.setValue(45.785234, forKey: "locationLat")
            concert5.setValue(4.858123, forKey: "locationLgn")
            concert5.artist = vegedream
            
            //Single
            let sunflower = Single(context: context)
            sunflower.setValue(false, forKey: "isNew")
            sunflower.setValue("sunflower_postmalone_lyrics", forKey: "lyrics")
            sunflower.setValue("Sunflower", forKey: "titleSingle")
            sunflower.setValue("postmalone_sunflower_video", forKey: "video")
            sunflower.artist = postmalone
            sunflower.album = hollywood
            
            let circles = Single(context: context)
            circles.setValue(true, forKey: "isNew")
            circles.setValue("circles_postmalone_lyrics", forKey: "lyrics")
            circles.setValue("Circles", forKey: "titleSingle")
            circles.setValue("postmalone_circles_video", forKey: "video")
            circles.artist = postmalone
            circles.album = hollywood
            
            let psycho = Single(context: context)
            psycho.setValue(false, forKey: "isNew")
            psycho.setValue("psycho_postmalone_lyrics", forKey: "lyrics")
            psycho.setValue("Psycho", forKey: "titleSingle")
            psycho.setValue("postmalone_psycho_video", forKey: "video")
            psycho.artist = postmalone
            psycho.album = beerpong
            
            let rockstar = Single(context: context)
            rockstar.setValue(true, forKey: "isNew")
            rockstar.setValue("rockstar_postmalone_lyrics", forKey: "lyrics")
            rockstar.setValue("Rockstar", forKey: "titleSingle")
            rockstar.setValue("postmalone_rockstar_video", forKey: "video")
            rockstar.artist = postmalone
            rockstar.album = beerpong
            
            let thank = Single(context: context)
            thank.setValue(false, forKey: "isNew")
            thank.setValue("thanku_ariana_lyrics", forKey: "lyrics")
            thank.setValue("Thank U, Next", forKey: "titleSingle")
            thank.setValue("arianagrande_thank_video", forKey: "video")
            thank.artist = ariana
            thank.album = thankU
            
            let sevenRings = Single(context: context)
            sevenRings.setValue(false, forKey: "isNew")
            sevenRings.setValue("sevenrings_ariana_lyrics", forKey: "lyrics")
            sevenRings.setValue("7 rings", forKey: "titleSingle")
            sevenRings.setValue("arianagrande_sevenrings_video", forKey: "video")
            sevenRings.artist = ariana
            sevenRings.album = thankU
            
            let godWoman = Single(context: context)
            godWoman.setValue(false, forKey: "isNew")
            godWoman.setValue("godwoman_ariana_lyrics", forKey: "lyrics")
            godWoman.setValue("God is a woman", forKey: "titleSingle")
            godWoman.setValue("arianagrande_god_video", forKey: "video")
            godWoman.artist = ariana
            godWoman.album = sweetener
            
            let noTears = Single(context: context)
            noTears.setValue(false, forKey: "isNew")
            noTears.setValue("notears_ariana_lyrics", forKey: "lyrics")
            noTears.setValue("No tears left to cry", forKey: "titleSingle")
            noTears.setValue("arianagrande_notears_video", forKey: "video")
            noTears.artist = ariana
            noTears.album = sweetener
            
            let mamahe = Single(context: context)
            mamahe.setValue(false, forKey: "isNew")
            mamahe.setValue("mamahe_vegedream_lyrics", forKey: "lyrics")
            mamahe.setValue("Mama he", forKey: "titleSingle")
            mamahe.setValue("vegedream_mamahe_video", forKey: "video")
            mamahe.artist = vegedream
            mamahe.album = nil
            
            let marchandSable = Single(context: context)
            marchandSable.setValue(false, forKey: "isNew")
            marchandSable.setValue("marchanddesable_vegedream_lyrics", forKey: "lyrics")
            marchandSable.setValue("Marchand de sable", forKey: "titleSingle")
            marchandSable.setValue("vegedream_marchand_video", forKey: "video")
            marchandSable.artist = vegedream
            marchandSable.album = nil
            
            let powerless = Single(context: context)
            powerless.setValue(true, forKey: "isNew")
            powerless.setValue("linkinpark_powerless_lyrics", forKey: "lyrics")
            powerless.setValue("Powerless", forKey: "titleSingle")
            powerless.setValue("linkinpark_powerless_video", forKey: "video")
            powerless.artist = linkin
            powerless.album = nil
            
            let lostEcho = Single(context: context)
            lostEcho.setValue(true, forKey: "isNew")
            lostEcho.setValue("linkinpark_lostintheecho_lyrics", forKey: "lyrics")
            lostEcho.setValue("Lost in the echo", forKey: "titleSingle")
            lostEcho.setValue("linkinpark_lostintheecho_video", forKey: "video")
            lostEcho.artist = linkin
            lostEcho.album = nil

            let newDivide = Single(context: context)
            newDivide.setValue(false, forKey: "isNew")
            newDivide.setValue("linkinpark_newdivide_lyrics", forKey: "lyrics")
            newDivide.setValue("New Divide", forKey: "titleSingle")
            newDivide.setValue("linkinpark_newdivide_video", forKey: "video")
            newDivide.artist = linkin
            newDivide.album = nil

            let oneMoreLight = Single(context: context)
            oneMoreLight.setValue(true, forKey: "isNew")
            oneMoreLight.setValue("linkinpark_onemoreligth_lyrics", forKey: "lyrics")
            oneMoreLight.setValue("One more ligth", forKey: "titleSingle")
            oneMoreLight.setValue("linkinpark_onemoreligth_video", forKey: "video")
            oneMoreLight.artist = linkin
            oneMoreLight.album = nil
            
            let catalyst = Single(context: context)
            catalyst.setValue(true, forKey: "isNew")
            catalyst.setValue("linkinpark_catalyst_lyrics", forKey: "lyrics")
            catalyst.setValue("Catalyst", forKey: "titleSingle")
            catalyst.setValue("linkinpark_catalyst_video", forKey: "video")
            catalyst.artist = linkin
            catalyst.album = nil
            
            let adventureLifetime = Single(context: context)
            adventureLifetime.setValue(true, forKey: "isNew")
            adventureLifetime.setValue("coldplay_adventureofalifetime_lyrics", forKey: "lyrics")
            adventureLifetime.setValue("Adventure of a lifetime", forKey: "titleSingle")
            adventureLifetime.setValue("coldplay_adventureofalifetime_video", forKey: "video")
            adventureLifetime.artist = coldplay
            adventureLifetime.album = nil

            let theScientist = Single(context: context)
            theScientist.setValue(true, forKey: "isNew")
            theScientist.setValue("coldplay_thescientist_lyrics", forKey: "lyrics")
            theScientist.setValue("The scientist", forKey: "titleSingle")
            theScientist.setValue("coldplay_thescientist_video", forKey: "video")
            theScientist.artist = coldplay
            theScientist.album = nil
            
            let skyStars = Single(context: context)
            skyStars.setValue(false, forKey: "isNew")
            skyStars.setValue("coldplay_askyfullofstars_lyrics", forKey: "lyrics")
            skyStars.setValue("One more ligth", forKey: "titleSingle")
            skyStars.setValue("coldplay_askyfullofstars_video", forKey: "video")
            skyStars.artist = coldplay
            skyStars.album = nil

            let hymnWeekend = Single(context: context)
            hymnWeekend.setValue(false, forKey: "isNew")
            hymnWeekend.setValue("coldplay_hymnfortheweekend_lyrics", forKey: "lyrics")
            hymnWeekend.setValue("Hymn for the weekend", forKey: "titleSingle")
            hymnWeekend.setValue("coldplay_hymnfortheweekend_video", forKey: "video")
            hymnWeekend.artist = coldplay
            hymnWeekend.album = nil

            let aeou = Single(context: context)
            aeou.setValue(true, forKey: "isNew")
            aeou.setValue("olivierfrancis_aeou_lyrics", forKey: "lyrics")
            aeou.setValue("Aeou", forKey: "titleSingle")
            aeou.setValue("oliver_aeou_video", forKey: "video")
            aeou.artist = olivier
            aeou.album = nil
            
            let antiGrav = Single(context: context)
            antiGrav.setValue(false, forKey: "isNew")
            antiGrav.setValue("olivierfrancis_antigrav_lyrics", forKey: "lyrics")
            antiGrav.setValue("Anti-Grav", forKey: "titleSingle")
            antiGrav.setValue("oliver_antigrav_video", forKey: "video")
            antiGrav.artist = olivier
            antiGrav.album = nil
            
            let gemini = Single(context: context)
            gemini.setValue(true, forKey: "isNew")
            gemini.setValue("olivierfrancis_gemini_lyrics", forKey: "lyrics")
            gemini.setValue("Gemini", forKey: "titleSingle")
            gemini.setValue("oliver_gemini_video", forKey: "video")
            gemini.artist = olivier
            gemini.album = nil 
            
            do {
                try context.save()
                print("Context of databse saved !")
            } catch {
                print("Error impossible to save context !")
            }
        } else {
            print("L'utilisateur root existe")
        }
    }
    
    static func didContainRoot(users : [User]) -> Bool {
        var exist : Bool = false
        var i : Int = 0
        while i<users.count {
            if users[i].username == "root" {
                exist = true
            }
            i+=1
        }
        return exist
    }
}

class PrepopulateFavorite {
    
    static func makeFavorite(){
        print("Make favorite launch")
        let playlists = Playlist.playlistOfActualUser
        if(!didContainFavorite(playlists: playlists)){
            print("la playlist favorite n'existe pas sur \(User.actualUser.first?.username ?? "null")")
            let context = AppDelegate.viewContext
            let newPlaylistFavorite = Playlist(context: context)
            newPlaylistFavorite.setValue("like", forKey: "logoName")
            newPlaylistFavorite.setValue("Favorite", forKey: "name")
            newPlaylistFavorite.user = User.actualUser.first
            //            newUserRoot.setValue("", forKey: "userPicture")
            do {
                try context.save()
                print("Context saved !")
            } catch {
                print("Error impossible to save context !")
            }
        } else {
            print("La playlist favorite existe")
        }
    }
    
    static func didContainFavorite(playlists : [Playlist]) -> Bool {
        var exist : Bool = false
        var i : Int = 0
        while i<playlists.count {
            if playlists[i].name == "Favorite" {
                exist = true
            }
            i+=1
        }
        return exist
    }
}

