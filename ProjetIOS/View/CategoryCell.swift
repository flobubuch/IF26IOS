//
//  CategoryCell.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 14/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit

class CategoryCellHome : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    private let itemCellID = "itemCellID"
    
    var viewController : HomeSceneController?
    
    var appCategory : AppCategoryHome? {
        didSet{
            if let name = appCategory?.name {
                titleLabel.text = "     \(name)"
                titleLabel.textAlignment = .center
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "  My Playlist"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView : UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7007163167, green: 0.7008357644, blue: 0.7007005811, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        
        backgroundColor = UIColor.clear
        
        addSubview(titleLabel)
        addSubview(itemCollectionView)
        addSubview(dividerLineView)
        
        itemCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: itemCellID)

 
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": itemCollectionView]))
//
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views:  ["superview":frame,"v0": titleLabel]))
        //[nameLabel(30)] ,"nameLabel" : nameLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v2(30)][v0][v1(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": itemCollectionView, "v1":dividerLineView, "v2":titleLabel]))
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.items?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellID, for: indexPath) as! ItemCell
        cell.item = appCategory?.items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = appCategory?.items?[indexPath.item] {
            viewController?.showDetailForApp(item: item)
        }
    }
    
}

class CategoryCellNew : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    private let itemCellID = "itemCellID"
    
    var newCollectionViewController : NewSceneController?
    
    var appCategory : AppCategoryNew? {
        didSet{
            if let name = appCategory?.name {
                titleLabel.text = "     \(name)"
                titleLabel.textAlignment = .center
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "  My Playlist"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView : UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7007163167, green: 0.7008357644, blue: 0.7007005811, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        
        backgroundColor = UIColor.clear
        
        addSubview(titleLabel)
        addSubview(itemCollectionView)
        addSubview(dividerLineView)
        
        itemCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: itemCellID)

 
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": itemCollectionView]))
//
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views:  ["superview":frame,"v0": titleLabel]))
        //[nameLabel(30)] ,"nameLabel" : nameLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v2(30)][v0][v1(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:  ["v0": itemCollectionView, "v1":dividerLineView, "v2":titleLabel]))
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.items?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellID, for: indexPath) as! ItemCell
        cell.item = appCategory?.items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = appCategory?.items?[indexPath.item] {
            newCollectionViewController?.showDetailForApp(item: item)
        }
    }
    
}


class ItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupViews()
    }
    
    var item : Item? {
        didSet{
            nameLabel.text = item?.name1
            artistLabel.text = item?.name2
            if item?.imageName == "add_to_playlist_icon" {
                imageView.backgroundColor = .gray
            }
            imageView.image = UIImage(named: (item?.imageName)!)
            category = item!.category!
        }
    }
    
    required init?(coder Adecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.layer.masksToBounds = true
        return iv
    }()

    let nameLabel : UILabel = {
       let label = UILabel()
        label.text = "Favorite"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let artistLabel : UILabel = {
        let label = UILabel()
        label.text = "Artist Default"
        label.textColor = #colorLiteral(red: 0.8787264228, green: 0.8788741231, blue: 0.8787069917, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var category : String = {
        return "default"
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(artistLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width+4, width: frame.width, height: 18)
        artistLabel.frame = CGRect(x: 0, y: frame.width+20, width: frame.width, height: 16)
    }
}
