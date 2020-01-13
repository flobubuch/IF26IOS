//
//  CollectionViews.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 27/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

class CollectionViewPlaylist: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "CellID"
    var listSingles : [Single] = []
    var viewController : UIViewController?
    var noSingle = false
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(SingleCell.self, forCellWithReuseIdentifier: cellID)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listSingles.count != 0 {
            noSingle = false
            return listSingles.count
        } else {
            noSingle = true
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SingleCell
        if !noSingle {
            let single = listSingles[indexPath.item]
            cell.textLabel.text = single.titleSingle
            cell.textLabelArtist.text = single.artist?.name
            cell.item = createItem(single: single)
        } else {
            cell.textLabel.text = "Vous n'avez ajouté aucun single"
            cell.textLabel.contentMode = .center
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (viewController as! PlaylistViewController).segueShowSingle(item: createItem(single: listSingles[indexPath.item]))
    }
    
    private func createItem(single : Single) -> Item {
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
        return item
    }
}

class SelectImageCollectionViewCell : UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    let cellID = "cellID"
    
    let tableImagePlaylist = ["rap", "rap2", "rap3", "rap4", "rock", "rock2", "rock3", "rock4", "rock5", "reggae", "reggae2", "jazz", "jazz2", "jazz3", "electro", "electro2", "electro3", "pop"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(SelectImageCell.self, forCellWithReuseIdentifier: cellID)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SelectImageCell
        cell.imageView.image = UIImage(named: tableImagePlaylist[indexPath.item])
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 1.5, height: frame.height)
    }
    
}

class CreatePlaylistCollectionView : SelectImageCollectionViewCell {
    var viewController : PopUpSecondViewController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.registerPlaylist(imageName: tableImagePlaylist[indexPath.item])
    }
}

class ChangePhotoCollectionView : SelectImageCollectionViewCell {
    var viewController : SelectUserPicViewController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.changeUserPhoto(imageName: tableImagePlaylist[indexPath.item])
    }
}

class SelectImageCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
    }
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "reggae")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height)
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class CollectionViewAlbum: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "CellID"
    var listSingles : [Single] = []
    var viewController : UIViewController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(SingleCell.self, forCellWithReuseIdentifier: cellID)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSingles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SingleCell
        let single = listSingles[indexPath.item]
        cell.textLabel.text = single.titleSingle
        cell.item = createItem(single: single)
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (viewController as! AlbumViewController).segueShowSingle(item: createItem(single: listSingles[indexPath.item]))
    }
    
    private func createItem(single : Single) -> Item {
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
        return item
    }
}

class SingleCell : UICollectionViewCell {
    
    var item : Item?
    
    let textLabel : UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tl.textAlignment = .left
        tl.font = .boldSystemFont(ofSize: 18)
        return tl
    }()
    
    let textLabelArtist : UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tl.textAlignment = .left
        tl.font = .boldSystemFont(ofSize: 12)
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(textLabel)
        addSubview(textLabelArtist)
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        textLabelArtist.frame = CGRect(x: 0, y: 20, width: frame.width, height: frame.height)
        backgroundColor = .clear
    }
    
}

class CollectionViewArtistPage : UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var menuBar : MenuBarArtist?
    let cellID = "cellID"
    let newID = "newID"
    let bioID = "bioID"
    var bio : String?
    var listAlbums : [Album] = []
    var listSingles : [Single] = []
    var viewController : ArtistViewController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(AlbumViewCellArtist.self, forCellWithReuseIdentifier: cellID)
        register(SingleViewCell.self, forCellWithReuseIdentifier: newID)
        register(BioCell.self, forCellWithReuseIdentifier: bioID)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        switch indexPath.item {
        case 0:
            cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlbumViewCellArtist
            (cell as! AlbumViewCellArtist).listAlbums = listAlbums
            (cell as! AlbumViewCellArtist).emptyPhrase = "Cet artiste ne possède pas d'album"
            (cell as! AlbumViewCellArtist).viewController = viewController
        case 1:
            cell = dequeueReusableCell(withReuseIdentifier: newID, for: indexPath) as! SingleViewCell
            (cell as! SingleViewCell).listSingles = listSingles
            (cell as! SingleViewCell).viewController = viewController
        case 2:
            cell = dequeueReusableCell(withReuseIdentifier: bioID, for: indexPath) as! BioCell
            (cell as! BioCell).textLabel.text = setLyrics()
        default:
            break
        }
        return cell!
    }
    
    private func setLyrics() -> String? {
        let bundle = Bundle.main
        let path = bundle.path(forResource: bio, ofType: "txt")
        do {
           return try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar?.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2.75
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar?.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
    }
    
}

class CollectionViewProfilePage : UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var menuBar : MenuBarProfile?
    let playlistID = "playlistID"
    let artistID = "artistID"
    let albumID = "albumID"
    var bio : String?
    var viewController : ProfileSceneController?
    var listAlbums : [Album] = []
    var listArtists : [Artist] = []
    var listPlaylists : [Playlist] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(PlaylistViewCell.self, forCellWithReuseIdentifier: playlistID)
        register(ArtistViewCell.self, forCellWithReuseIdentifier: artistID)
        register(AlbumViewCellProfile.self, forCellWithReuseIdentifier: albumID)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        switch indexPath.item {
        case 0:
            cell = dequeueReusableCell(withReuseIdentifier: playlistID, for: indexPath) as! PlaylistViewCell
            (cell as! PlaylistViewCell).listPlaylists = listPlaylists
            (cell as! PlaylistViewCell).emptyPhrase = "Vous n'avez aucune playlist"
            (cell as! PlaylistViewCell).viewController = viewController
        case 1:
            cell = dequeueReusableCell(withReuseIdentifier: artistID, for: indexPath) as! ArtistViewCell
            (cell as! ArtistViewCell).listArtists = listArtists
            (cell as! ArtistViewCell).viewController = viewController
        case 2:
            cell = dequeueReusableCell(withReuseIdentifier: albumID, for: indexPath) as! AlbumViewCellProfile
            (cell as! AlbumViewCellProfile).listAlbums = listAlbums
            (cell as! AlbumViewCellProfile).emptyPhrase = "Vous n'avez like aucun album"
            (cell as! AlbumViewCellProfile).viewController = viewController
        default:
            break
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar?.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2.75
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar?.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
    }
    
}

class AlbumViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var listAlbums : [Album] = []
    var noAlbum = false
    var emptyPhrase : String?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listAlbums.count != 0 {
            noAlbum = false
            return listAlbums.count
        } else {
            noAlbum = true
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !noAlbum {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlbumPlaylistCell
            cell.textLabel.text = listAlbums[indexPath.item].titleAlbum
            cell.imageView.image = UIImage(named: listAlbums[indexPath.item].image!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noAlbumID, for: indexPath) as! SingleCell
            cell.textLabel.text = emptyPhrase
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellID = "cellID"
    let noAlbumID = "noAlbumID"
    
    private func setupViews() {
        backgroundColor = .clear
        
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        collectionView.register(AlbumPlaylistCell.self , forCellWithReuseIdentifier: cellID)
        collectionView.register(SingleCell.self , forCellWithReuseIdentifier: noAlbumID)
        
    }
    
    func createItem(album : Album) -> Item {
        let item = Item()
        item.name1 = album.artist?.name
        item.name2 = album.titleAlbum
        item.category = "Album"
        item.imageName = album.image
        return item
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumViewCellArtist: AlbumViewCell {
    var viewController : ArtistViewController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listAlbums.count != 0 {
            viewController?.segueShowAlbum(item: createItem(album: listAlbums[indexPath.item]))
        }
    }
    
}

class AlbumViewCellProfile: AlbumViewCell {
    var viewController : ProfileSceneController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listAlbums.count != 0 {
            viewController?.segueShowAlbum(item: createItem(album: listAlbums[indexPath.item]))
        }
    }
}

class PlaylistViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    var listPlaylists : [Playlist] = []
    var viewController : ProfileSceneController?
    var noPlaylist = false
    var emptyPhrase : String?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listPlaylists.count != 0 {
            noPlaylist = false
            return listPlaylists.count
        } else {
            noPlaylist = true
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !noPlaylist {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlbumPlaylistCell
            cell.textLabel.text = listPlaylists[indexPath.item].name
            cell.imageView.image = UIImage(named: listPlaylists[indexPath.item].logoName!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noAlbumID, for: indexPath) as! SingleCell
            cell.textLabel.text = emptyPhrase
            return cell
        }
        
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != .ended {
            print("ended gesture")
            return
        }
        
        let p = gesture.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            print("long press")
            segue(playlistName: listPlaylists[indexPath.item].name!)
            
        } else {
            print("couldn't find index path")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listPlaylists.count != 0 {
            viewController?.segueShowPlaylist(item: createItem(playlist: listPlaylists[indexPath.item]))
        }
    }
    
    private func createItem(playlist : Playlist) -> Item {
        let item = Item()
        item.name1 = playlist.name
        item.name2 = ""
        item.category = "Playlist"
        item.imageName = playlist.logoName
        return item
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellID = "cellID"
    let noAlbumID = "noAlbumID"
    
    private func setupViews() {
        backgroundColor = .clear
        
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        collectionView.register(AlbumPlaylistCell.self , forCellWithReuseIdentifier: cellID)
        collectionView.register(SingleCell.self , forCellWithReuseIdentifier: noAlbumID)
        
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.addGestureRecognizer(lpgr)
        
    }
    
    private func segue(playlistName : String) {
        viewController?.segueShowDeletePlaylist(playlistName: playlistName)
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SingleViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var listSingles : [Single] = []
    var viewController : ArtistViewController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(listSingles.count)
        return listSingles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SingleCell
        cell.textLabel.text = listSingles[indexPath.item].titleSingle
        cell.textLabelArtist.text = listSingles[indexPath.item].artist?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellID = "cellID"
    
    private func setupViews() {
        backgroundColor = .clear
        
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        collectionView.register(SingleCell.self , forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.segueShowSingle(item: createItem(single: listSingles[indexPath.item]))
    }
    
    private func createItem(single : Single) -> Item {
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
        return item
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ArtistViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var listArtists : [Artist] = []
    var viewController : ProfileSceneController?
    var noArtist = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listArtists.count != 0 {
            noArtist = false
            return listArtists.count
        } else {
            noArtist = true
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !noArtist {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ArtistCell
            cell.textLabel.text = listArtists[indexPath.item].name
            cell.imageView.image = UIImage(named: listArtists[indexPath.item].image!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noArtistID, for: indexPath) as! SingleCell
            cell.textLabel.text = "Vous n'avez like aucun artiste"
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listArtists.count != 0 {
            viewController?.segueShowArtist(item: createItem(artist: listArtists[indexPath.item]))
        }
    }
    
    private func createItem(artist : Artist) -> Item {
        let item = Item()
        item.name1 = artist.name
        item.name2 = ""
        item.category = "Artist"
        item.imageName = artist.image
        item.ranking = artist.topArtist
        return item
    }
    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellID = "cellID"
    let noArtistID = "noArtistID"
    
    private func setupViews() {
        backgroundColor = .clear
        
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        collectionView.register(ArtistCell.self , forCellWithReuseIdentifier: cellID)
        collectionView.register(SingleCell.self , forCellWithReuseIdentifier: noArtistID)
        
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class AlbumPlaylistCell: UICollectionViewCell {
    
    let textLabel : UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tl.text = "Album name"
        tl.textAlignment = .left
        tl.font = .boldSystemFont(ofSize: 18)
        return tl
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "postmalonealb")
        return iv
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(textLabel)
        addSubview(imageView)
        textLabel.frame = CGRect(x: 60, y: 0, width: frame.width - 60, height: frame.height)
        imageView.frame = CGRect(x: 0, y: 5, width: 40, height: 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ArtistCell: UICollectionViewCell {
    
    let textLabel : UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tl.text = "Album name"
        tl.textAlignment = .left
        tl.font = .boldSystemFont(ofSize: 18)
        return tl
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "postmalonealb")
        return iv
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(textLabel)
        addSubview(imageView)
        textLabel.frame = CGRect(x: 60, y: 0, width: frame.width - 60, height: frame.height)
        imageView.frame = CGRect(x: 0, y: 5, width: 25, height: 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BioCell: UICollectionViewCell {
    
    let textLabel : UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tl.text = "blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla"
        tl.textAlignment = .center
        tl.numberOfLines = 0
        tl.font = .boldSystemFont(ofSize: 18)
        return tl
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(textLabel)
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
        
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cellID = "cellID"
    private let longCellID = "longCellID"
    var appCategories : [AppCategoryHome]?
    var viewController : HomeSceneController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.delegate = self
        self.dataSource = self
        register(CategoryCellHome.self, forCellWithReuseIdentifier: cellID)
        register(LongCategoryCell.self, forCellWithReuseIdentifier: longCellID)
        appCategories = AppCategoryHome.sampleAppCategoriesHome()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: longCellID, for: indexPath) as! LongCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            cell.viewController = viewController
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCellHome
        cell.appCategory = appCategories?[indexPath.item]
        cell.viewController = viewController
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 3 {
            return CGSize(width: frame.width,height: 335)
        }
        return CGSize(width: frame.width, height: 230)
    }
    
    
}

class NewCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cellID = "cellID"
    var appCategories : [AppCategoryNew]?
    var viewController : NewSceneController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.delegate = self
        self.dataSource = self
        register(CategoryCellNew.self, forCellWithReuseIdentifier: cellID)
        appCategories = AppCategoryNew.sampleAppCategoriesNew()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCellNew
        cell.appCategory = appCategories?[indexPath.item]
        cell.newCollectionViewController = viewController
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: frame.width, height: 230)
    }
    
    
}

    


class PlaylistToAddCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var listPlaylists : [Playlist] = []
    var viewController : AddToPlaylistViewController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return listPlaylists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlbumPlaylistCell
            cell.textLabel.text = listPlaylists[indexPath.item].name
            cell.imageView.image = UIImage(named: listPlaylists[indexPath.item].logoName!)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.registerInPlaylist(playlist: listPlaylists[indexPath.item])
    }
    
    let cellID = "cellID"
    
    private func setupViews() {
        backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        register(AlbumPlaylistCell.self , forCellWithReuseIdentifier: cellID)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

