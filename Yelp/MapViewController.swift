//
//  MapViewController.swift
//  Yelp
//
//  Created by Aarnav Ram on 19/02/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var businessArray:[Business] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(self.businessArray)
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        let centerLocation = CLLocation(latitude: 40.425869, longitude: -86.908066)
        goToLocation(location: centerLocation)
        
        for business in businessArray {
            addPinUsingAddressString(businessName: business.name!, address: business.address!)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    func addPinUsingAddressString(businessName:String, address:String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (locations, error) in
            if let locations = locations {
                if locations.count != 0 {
                    let coordinate = locations.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = businessName
                    self.mapView.addAnnotation(annotation)

                }
            }
        }
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        let identifier = "customAnnotationView"
//        // custom pin annotation
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//        if (annotationView == nil) {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//        
//        let btn = UIButton(type: .detailDisclosure)
//        annotationView?.rightCalloutAccessoryView = btn
//        return annotationView
//    }
//    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let business = view.annotation as! Business
//        let placeName = business.title
//        let placeInfo = business.address
//        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        self.mapView.setRegion(region, animated: false)
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
