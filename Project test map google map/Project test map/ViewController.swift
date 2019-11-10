//
//  ViewController.swift
//  Project test map
//
//  Created by Neptune Wong on 6/11/2019.
//  Copyright © 2019 Neptune Wong. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var MapView: GMSMapView!
    var myLocationMgr: CLLocationManager!
    let defaultCenter = CLLocationCoordinate2D(latitude: -32.725757, longitude: 21.481987)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let camera = GMSCameraPosition.camera(withLatitude: 34.67583, longitude: 135.500520, zoom: 12.0)
        //MapView.camera = camera
        myLocationMgr = CLLocationManager()
        myLocationMgr.delegate = self
        myLocationMgr.requestWhenInUseAuthorization() // request user authorize
        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters // update data after move ten meters
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
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
