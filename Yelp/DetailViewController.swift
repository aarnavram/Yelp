//
//  DetailViewController.swift
//  Yelp
//
//  Created by Aarnav Ram on 19/02/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var customMapView: MKMapView!
    var business:Business!
    var locationManager: CLLocationManager!

    @IBOutlet weak var scrollView: UIScrollView!
    
    var image:UIImage!
    var name:String!
    var address:String!
    var ratingImage:UIImage!
    
    @IBOutlet weak var mainImageVIew: UIImageView!
    @IBOutlet weak var ratingLabel: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageVIew.image = image
        mainImageVIew.layer.cornerRadius = 64
        mainImageVIew.clipsToBounds = true
        ratingLabel.image = ratingImage
        addressLabel.text = address
        businessName.text = name
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        
        addPinUsingAddressString(businessName: name, address: address)
        print(address)
        print(name)
        goToLocationWithAddress(address: address)
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: mainImageVIew.frame.origin.y + mainImageVIew.frame.size.height + customMapView.frame.size.height + 200)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPinUsingAddressString(businessName:String, address:String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (locations, error) in
            if let locations = locations {
                if locations.count != 0 {
                    let coordinateLoc = locations.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinateLoc.coordinate
                    annotation.title = businessName
                    self.customMapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    func goToLocationWithAddress(address:String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (locations, error) in
            if let locations = locations {
                if locations.count != 0 {
                    let coordinateLoc = locations.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinateLoc.coordinate
                    annotation.title = self.name
                    self.customMapView.addAnnotation(annotation)
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    let region = MKCoordinateRegionMake(coordinateLoc.coordinate, span)
                    self.customMapView.setRegion(region, animated: false)
                    
                }
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
