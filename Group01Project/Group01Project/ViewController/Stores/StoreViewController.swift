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
    
    @IBOutlet weak var viewForButton: UIView!
    @IBOutlet weak var place: UITableView!
    
    let locationManager = CLLocationManager()
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    
    var mapView:GMSMapView!
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var PlaceList = ["Central and Western","Eastern","Southern","Wan Chai","Sham Shui Po","Kowloon City","Kwun Tong","Wong Tai Sin","Yau Tsim Mong","Kwai Tsing","North","Sai Kung","Sha Tin","Tai Po","Tsuen Wan","Tuen Mun","Yuen Long","Islands"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        place.isHidden = true
        
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
    @objc func buttonAction(sender: UIButton!){
        if place.isHidden {
            animate(toogle: true)
        }else{
            animate(toogle: false)
        }
    }
    
    func animate(toogle: Bool) {
        if toogle{
            UIView.animate(withDuration: 0.3) {
                self.place.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.place.isHidden = true
            }
        }
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate 22.3700556, 114.1535941 at zoom level 6.
        super.loadView()
        //for button
        let button = UIButton()
        button.frame = self.viewForButton.frame
        
        // Set the font of the button text
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        // The default text of the button
        button.setTitle("Places", for: .normal)
        
        // The text that will appear when the button is tapped
        button.setTitle("I am being tapped", for: .highlighted)
        
        // The default color of the button text
        button.setTitleColor(UIColor.black, for: .normal)
        
        // The color of the button text when the button is tapped
        button.setTitleColor(UIColor.black, for: .highlighted)
        button.layer.zPosition = 100
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        self.view.addSubview(button)
        
        //for map
        let camera = GMSCameraPosition.camera(withLatitude: 22.3700556, longitude: 114.1535941, zoom: 11.0)
        
        mapView = GMSMapView.map(withFrame:CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.center = self.view.center
        //        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        //        view = mapView
        viewForButton.layer.zPosition = 100
        
        view.addSubview(mapView)
        
        
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


extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = PlaceList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadView().button.setTitle("PlaceList[indexPath.row]", for: .normal)
        animate(toogle: false)
    }
    
    
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

