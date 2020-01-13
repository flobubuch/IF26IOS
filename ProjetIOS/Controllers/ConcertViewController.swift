//
//  ConcertViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 18/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import MapKit

class ConcertViewController: UIViewController {
    @IBOutlet weak var artistResultLabel: UILabel!
    @IBOutlet weak var dateResultLabel: UILabel!
    @IBOutlet weak var concertResultLabel: UILabel!
    @IBOutlet weak var locationResultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var concertAnnotation : ConcertAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientBackground()
        setItemProperties()
        setMapView()
        navigationItem.title = "Concert"
        
        // Do any additional setup after loading the view.
    }
    
    
    private func setMapView() {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let concertCoordinate = CLLocationCoordinate2DMake(item!.locationLat!, item!.locationLgn!)
        let concertAnnotation = ConcertAnnotation(coordinate: concertCoordinate, title: item?.location!, subtitle: "Concert de \(item!.name1!))")
        self.concertAnnotation = concertAnnotation
        mapView.addAnnotation(concertAnnotation)
        mapView.setRegion(concertAnnotation.region, animated: true)
    }
    
    func setItemProperties() {
        if let myItem = item {
            artistResultLabel.text = myItem.name1
            dateResultLabel.text = myItem.date
            concertResultLabel.text = myItem.name2
            locationResultLabel.text = myItem.location!+"\n"
            if let imageName = myItem.imageName {
                imageView.image = UIImage(named: imageName)
                imageView.contentMode = .scaleToFill
            }
        }
    }
    
    var item : Item? {
        didSet {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "artistFromConcert" || segue.identifier == "artistFromConcert2" {
            let artistVC = segue.destination as! ArtistViewController
            let artist = Artist.artistFromName(artistName: item!.name1!).first!
            let item = Item()
            item.name1 = artist.name
            item.name2 = ""
            item.category = "Artist"
            item.imageName = artist.image
            item.ranking = artist.topArtist
            artistVC.item = item
        }
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }

    @IBAction func focusOnClick() {
        if focusButton.title(for: .normal) == "FOCUS" {
            focusButton.setTitle("UNFOCUS", for: .normal)
            mapView.setRegion(concertAnnotation!.regionZoom, animated: true)
        } else {
            focusButton.setTitle("FOCUS", for: .normal)
            mapView.setRegion(concertAnnotation!.region, animated: true)
        }
        
    }
}

final class ConcertAnnotation : NSObject, MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var title : String?
    var subtitle: String?
    
    init(coordinate : CLLocationCoordinate2D, title : String?, subtitle : String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
    
    var regionZoom : MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
    
    var region : MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

extension Concert : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let concertAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            concertAnnotationView.animatesWhenAdded = true
            concertAnnotationView.titleVisibility = .adaptive
            concertAnnotationView.titleVisibility = .adaptive
            
            return concertAnnotationView
        }
        return nil
    }
}
