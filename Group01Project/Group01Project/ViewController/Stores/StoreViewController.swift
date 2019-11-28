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
import DropDown

class StoreViewController: BaseViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var viewForButton: UIView!
    var button = UIButton()
    var dropDown = DropDown()
    
    let locationManager = CLLocationManager()
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    
    var isLoadedSearchAPI:Bool = false
    var mapView:GMSMapView!
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var PlaceList = ["Central and Western","Eastern","Southern","Wan Chai","Sham Shui Po","Kowloon City","Kwun Tong","Wong Tai Sin","Yau Tsim Mong","Kwai Tsing","North","Sai Kung","Sha Tin","Tai Po","Tsuen Wan","Tuen Mun","Yuen Long","Islands"]
//    var markers:[GMarker] = []
    var markers=Set<GMarker>()
    
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
    @objc func buttonAction(sender: UIButton!){
        dropDown.show()
//        if place.isHidden {
            
//            place.layer.zPosition = 100
//            view.sendSubviewToBack(mapView)
//            animate(toogle: true)
//            place.isUserInteractionEnabled = true
//            mapView.isUserInteractionEnabled = false
//            //            self.view.bringSubviewToFront(viewForButton)
//            self.viewForButton.bringSubviewToFront(place)
//
//            print("Place user interaction = \(place.isUserInteractionEnabled)")
            //            print("Place \(place.)")
            
//        }else{
//            animate(toogle: false)
//        }
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate 22.3700556, 114.1535941 at zoom level 6.
        super.loadView()
        //for button
        
        button.frame = self.viewForButton.frame
        
        button.cornerRadius = 10
        button.borderWidth = 5
        // Set the font of the button text
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        button.setBackgroundImage(UIImage.init(color: .white), for: .normal)
        
        // The default text of the button
        button.setTitle("Places", for: .normal)
        
        // The text that will appear when the button is tapped
//        button.setTitle("I am being tapped", for: .highlighted)
        
        // The default color of the button text
        button.setTitleColor(UIColor.black, for: .normal)
        
        // The color of the button text when the button is tapped
        button.setTitleColor(UIColor.black, for: .highlighted)
        button.layer.zPosition = 100
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        dropDown.dataSource = PlaceList
        dropDown.anchorView = viewForButton
        dropDown.direction = .bottom
        dropDown.cellHeight = 45
        dropDown.bottomOffset = CGPoint(x: 0, y:viewForButton.bounds.height/2)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.button.setTitle("\(item)", for: .normal)
            var camera: GMSCameraPosition = GMSCameraPosition()
            
            if self.button.titleLabel?.text == "Central and Western" {
                camera = GMSCameraPosition.camera(withLatitude: 22.282115, longitude: 114.150952, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Eastern" {
                camera = GMSCameraPosition.camera(withLatitude: 22.279458, longitude:  114.225114, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Southern" {
                camera = GMSCameraPosition.camera(withLatitude: 22.238400, longitude: 114.195040, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Wan Chai" {
                camera = GMSCameraPosition.camera(withLatitude: 22.272365, longitude:  114.185052, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Sham Shui Po" {
                camera = GMSCameraPosition.camera(withLatitude: 22.332401, longitude:  114.155752, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Kowloon City" {
                camera = GMSCameraPosition.camera(withLatitude: 22.329341, longitude:  114.193341, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Kwun Tong" {
                camera = GMSCameraPosition.camera(withLatitude: 22.318703, longitude: 114.215730, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Wong Tai Sin" {
                camera = GMSCameraPosition.camera(withLatitude: 22.345828, longitude:  114.195964, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Yau Tsim Mong" {
                camera = GMSCameraPosition.camera(withLatitude: 22.312566, longitude: 114.170738 , zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Kwai Tsing" {
                camera = GMSCameraPosition.camera(withLatitude: 22.349689, longitude: 114.116549, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "North" {
                camera = GMSCameraPosition.camera(withLatitude: 22.510726, longitude: 114.161783, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Sai Kung" {
                camera = GMSCameraPosition.camera(withLatitude: 22.357449, longitude: 114.251295 , zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Sha Tin" {
                camera = GMSCameraPosition.camera(withLatitude: 22.390321, longitude: 114.202504, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Tai Po" {
                camera = GMSCameraPosition.camera(withLatitude: 22.460286, longitude: 114.197886, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Tsuen Wan" {
                camera = GMSCameraPosition.camera(withLatitude: 22.370848, longitude: 114.094151, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Tuen Mun" {
                camera = GMSCameraPosition.camera(withLatitude: 22.420046, longitude: 113.982891, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Yuen Long" {
                camera = GMSCameraPosition.camera(withLatitude: 22.444638, longitude: 114.040671, zoom: 11.0)
                self.mapView.center = self.view.center
            }else if self.button.titleLabel?.text == "Islands" {
                camera = GMSCameraPosition.camera(withLatitude: 22.296049, longitude: 113.958418, zoom: 11.0)
                self.mapView.center = self.view.center
            }
            self.mapView.animate(to: camera)
            SyncData().syncStore(type: "bank", lat: camera.target.latitude, lng: camera.target.longitude, radius: 1500){
                [weak self](storeResponse) in
                for store in storeResponse.results{
                    let marker:GMarker = GMarker(name: store.name!, icon: store.icon ?? "", location: store.geometry?.location, type: store.types)
                    self!.markers.insert(marker)
                }
                for marker in self!.markers {
                    self!.createMarker(marker: marker, self!.locationManager)
                }
                //                print(self!.markers)
                
            }
//          print("Selected item: \(item) at index: \(index)")
        }
        
        dropDown.cancelAction = { [unowned self] in
          print("Drop down dismissed")
        }

        dropDown.willShowAction = { [unowned self] in
          print("Drop down will show")
        }
        
        
        
        //for map
        let camera = GMSCameraPosition.camera(withLatitude: 22.3700556, longitude: 114.1535941, zoom: 11.0)
        
        mapView = GMSMapView.map(withFrame:CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.center = self.view.center
        //        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        //        view = mapView
        viewForButton.layer.zPosition = 100
        mapView.layer.zPosition = 0
        
        self.view.addSubview(mapView)
        self.view.addSubview(button)
        
        
        
        // Creates a marker in the center of the map.
        for i in 0...5 {
            let marker = GMSMarker()
                  
            marker.position = CLLocationCoordinate2D(latitude: 22.3700556 + Double(i), longitude: 114.1535941)
                        marker.title = "Sydney"
                       marker.snippet = "Australia"
                  marker.map = mapView
        }
      
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
        button.setTitle("\(PlaceList[indexPath.row])", for: .normal)
        
        
    }
    
    func createMarker(marker:GMarker,_ manager:CLLocationManager){
        var gMarker = GMSMarker()
        if(!marker.isShowed){
            marker.isShowed = !marker.isShowed
            gMarker.position = CLLocationCoordinate2D(latitude: marker.location!.lat!, longitude: marker.location!.lng!)
            gMarker.title = marker.name
            
            guard let image = toUIImage(marker: marker) else{
                print("maker cant translate the image")
                gMarker.map = mapView
                return
            }
            
            gMarker.icon = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            gMarker.icon?.draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))
    //        gMarker.setImageSize(scaledToSize: .init(width: 40, height: 40))
            gMarker.map = mapView
        } else {
            print("Marker is showed")
        }
    }

    // Create UIImage for marker
    func toUIImage(marker:GMarker)->UIImage?{
        var imageName:String = ""
        if((marker.icon)?.contains("atm"))!{
            imageName = "atm-71"
        } else if((marker.icon)?.contains("bank_dollar"))!{
            imageName = "bank_dollar-71"
        }
        if((marker.type?.contains("bank"))!){
            if(marker.name.contains("恆生")||marker.name.lowercased().contains("hang seng")){
                imageName = "hengseng-marker"
            } else if(marker.name.lowercased().contains("hsbc")){
                imageName = "hsbc-marker"
            } else if(marker.name.contains("渣打")||marker.name.lowercased().contains("standard chartered")){
                imageName = "standardchartered-marker"
            } else if(marker.name.lowercased().contains("bank of china")){
                imageName = "boc-marker"
            } else if(marker.name.lowercased().contains("construction")){
                imageName = "ccb-marker"
            } else if(marker.name.lowercased().contains("dah sing")){
                imageName = "dahsing-marker"
            } else if(marker.name.lowercased().contains("citi")){
                imageName = "citi-marker"
            } else if(marker.name.contains("東亞")||marker.name.lowercased().contains("east asia")){
                imageName = "bea-marker"
            }
            
        }
        
        return UIImage(named: imageName)?.RBResizeImage(targetSize: CGSize.init(width: 65, height: 65))
    }
    
    
    
    func marker (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var markerDict: [String: GMSMarker] = [:]
        struct State {
            let name: String
            let long: CLLocationDegrees
            let lat: CLLocationDegrees
        }
        var states : [State] = [State]()
        for state in states {
            let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            state_marker.title = state.name
            state_marker.snippet = "Hey, this is \(state.name)"
            state_marker.map = mapView
            markerDict[state.name] = state_marker
        }
        
        //test
        
        // *IMPORTANT* Assign all the spots data to the marker's userData property
        //marker.userData = spot
    }
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 14)
        if(!isLoadedSearchAPI){
//            syncData(type: "bank", lat: location.coordinate.latitude, lng: location.coordinate.longitude, radius: 1000)  { [weak self] (failReason) in
//
//                               if failReason != nil {
//
//
//                                 }
//                               }
            SyncData().syncStore(type: "bank", lat: location.coordinate.latitude, lng: location.coordinate.longitude, radius: 2000){
                [weak self](storeResponse) in
                for store in storeResponse.results{
                    let marker:GMarker = GMarker(name: store.name!, icon: store.icon ?? "", location: store.geometry?.location, type: store.types)
                    self!.markers.insert(marker)
                }
                for marker in self!.markers {
                    self!.createMarker(marker: marker, self!.locationManager)
                }
//                print(self!.markers)
                
            }

        }
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    func syncData(type:String, lat:Double, lng: Double, radius: Int, completed: ((SyncDataFailReason?) -> Void)?) {
//        SyncData().syncStore(type: type, lat: lat, lng: lng, radius: radius, completed: completed)
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

