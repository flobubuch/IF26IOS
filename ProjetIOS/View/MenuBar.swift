//
//  MenuBarArtist.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 23/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import UIKit
class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
   
    
    
    let cellID = "cellID"
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .clear
        setupCollectionView()
        setupHorizontalBar()
    }
    
    private func setupCollectionView() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(collectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        collectionView.backgroundColor = .clear
        
        selectItem0()
       
    }
    
    func selectItem0() {
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
               collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MenuBarArtist: MenuBar {
    
    var collectionViewPage : CollectionViewArtistPage?
    let menuTitle = ["ALBUM", "TITLES", "BIO"]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.textLabel.text = menuTitle[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionViewPage?.scrollToItem(at: indexPath, at: [], animated: true)
        }
}

class MenuBarProfile: MenuBar {
    var collectionViewPage : CollectionViewProfilePage?
    let menuTitle = ["PLAYLIST", "ARTIST", "ALBUM"]
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.textLabel.text = menuTitle[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionViewPage?.scrollToItem(at: indexPath, at: [], animated: true)
        }
}

class MenuCell : UICollectionViewCell {
    let textLabel : UILabel = {
        let tl = UILabel()
        tl.text = "ALBUM"
        tl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tl.textAlignment = .center
        tl.font = .boldSystemFont(ofSize: 18)
        return tl
    }()
    
    override var isSelected: Bool {
        didSet{
            textLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(textLabel)
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
}
