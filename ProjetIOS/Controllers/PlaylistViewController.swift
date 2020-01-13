//
//  PlaylistViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameResultLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var collectionView: CollectionViewPlaylist!
    
    var item : Item?
    var cv : CollectionViewPlaylist?
    
    private func setItemProperties() {
        nameResultLabel.text = item?.name1
        nameResultLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if let imageName = item?.imageName {
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleToFill
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        imageView.image = #imageLiteral(resourceName: "like")
        nameResultLabel.text = "FavoriteDefault"
        nameResultLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.text = "Titles"
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setItemProperties()
        navigationItem.title = "Playlist"
        
//        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cv?.removeFromSuperview()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let cv = CollectionViewPlaylist(frame: .zero, collectionViewLayout: layout)
        self.cv = cv
        cv.listSingles = Single.singleFromPlaylist(playlistName: item!.name1!)
        cv.viewController = self
        cv.backgroundColor = .clear
        collectionView.addSubview(cv)
        collectionView.backgroundColor = .clear
        
        cv.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }

    func segueShowSingle(item : Item) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mySingleController = mainStoryBoard.instantiateViewController(withIdentifier: "mySingleController") as? SingleViewController else {
            print("Couldn't find the view controller")
            return
        }
        mySingleController.item = item
        mySingleController.queueSingle = Single.singleFromPlaylist(playlistName: (self.item?.name1!)!)
        navigationController?.pushViewController(mySingleController, animated: true)
        //        present(myPlaylistController, animated: true, completion: nil)
    }

}
