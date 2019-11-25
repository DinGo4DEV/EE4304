//
//  StoreViewController.swift
//  Group01Project
//
//  Created by Stanley on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class StoreViewController: BaseViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var viewForMap: UIView!
    
    let locationManager = CLLocationManager()
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    
    var mapView:GMSMapView!
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            if(BaseViewController.loaded){
                self.stopLoading()
            }
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        placesClient = GMSPlacesClient.shared()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            print(currentLocation!.coordinate.longitude)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate 22.3700556, 114.1535941 at zoom level 6.
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: 22.3700556, longitude: 114.1535941, zoom: 11.0)
        mapView = GMSMapView.map(withFrame: self.viewForMap.frame/*CGRect.zero*/, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.view.addSubview(mapView)

//        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        //view = mapView
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        
        //      marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //      marker.title = "Sydney"
        //      marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //        mapView!.animate(toLocation: currentLocation.coordinate)
    }
    
}

extension StoreViewController {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 13)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .restricted:
                print("Location access was restricted.")
            case .denied:
                print("User denied access to location.")
                // Display the map using the default location.
                mapView.isHidden = false
            case .notDetermined:
                print("Location status not determined.")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

