//
//  ViewController.swift
//  Project test map
//
//  Created by Neptune Wong on 6/11/2019.
//  Copyright © 2019 Neptune Wong. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var MapView: GMSMapView!
    var myLocationMgr: CLLocationManager!
    let defaultCenter = CLLocationCoordinate2D(latitude: -60.725757, longitude: 21.481987)
    
    @IBOutlet weak var txtsearch: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtsearch.delegate = self
        // Do any additional setup after loading the view.
        //let camera = GMSCameraPosition.camera(withLatitude: 34.67583, longitude: 135.500520, zoom: 12.0)
        //MapView.camera = camera
        myLocationMgr = CLLocationManager()
        myLocationMgr.delegate = self
        myLocationMgr.requestWhenInUseAuthorization() // request user authorize
        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters // update data after move ten meters
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func textFieldShouldReturn(_ textField: UISearchBar) -> Bool {
        searchPlaceFromGoogle(place: textField.text!)
        return true
    }
    
    func searchPlaceFromGoogle(place:String){
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(place)&key=AIzaSyAp6m99o6NZ9DnwBywOv5SHzyGK2dFsUGc"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            if error == nil {
                let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print("json == \(jsonDict)")
            }else{
                 
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Get user author
        switch status {
        case .authorizedWhenInUse:
            myLocationMgr.startUpdatingLocation() // Start location
            MapView.isMyLocationEnabled = true
            MapView.settings.myLocationButton = true
            
        case .denied:
            let alertController = UIAlertController(title: "定位權限已關閉",
                                                    message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0] as CLLocation
        print("Current Location: \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
        
        if let location = locations.first {
            // Mark -
            CATransaction.begin()
            CATransaction.setValue(Int(2), forKey: kCATransactionAnimationDuration)
            MapView.animate(toLocation: location.coordinate)
            MapView.animate(toZoom: 12)
            CATransaction.commit()
            myLocationMgr.stopUpdatingLocation()
        }
        
    }
}
