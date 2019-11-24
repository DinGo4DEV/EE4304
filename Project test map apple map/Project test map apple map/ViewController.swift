//
//  ViewController.swift
//  Project test map apple map
//
//  Created by Neptune Wong on 10/11/2019.
//  Copyright © 2019 Neptune Wong. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    
    var location : CLLocationManager!
    var startLocation: CLLocation!
    //var bank: [Bank] = []
    
    @IBAction func tracking(_ sender: Any) {
        centerMapOnUserButtonClicked()
    }
    
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        // 生成 CLLocationManager 這物件
        location = CLLocationManager()
        // 指定其代理 delegate 委任對象
        location.delegate = self
        /*  設置自身定位精準度 _locationManager.desiredAccuracy
         *  設置移動距離精準度 _locationManager.distanceFilter
         *      kCLLocationAccuracyBestForNavigation：精確度最高，適用於導航的定位。
         *      kCLLocationAccuracyBest：精確度高。
         *      kCLLocationAccuracyNearestTenMeters：精確度 10 公尺以內。
         *      kCLLocationAccuracyHundredMeters：精確度 100 公尺以內。
         *      kCLLocationAccuracyKilometer：精確度 1 公里以內。
         *      kCLLocationAccuracyThreeKilometers：精確度 3 公里以內。
         */
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.distanceFilter = kCLLocationAccuracyNearestTenMeters
        
        /* 如果要調用 requestAlwaysAuthorization() 這個方法
         * 你必須在 Info.plist 當中加入 NSLocationAlwaysUsageDescription 這個 Key&Value
         * 說明為何要取得永遠授權的文字，這樣才能調用這個方法來取得 GPS 權限。
         */
        location.requestAlwaysAuthorization()
        
        /* 如果要調用 requestWhenInUseAuthorization() 這個方法
         * 你必須在 Info.plist 當中加入 NSLocationWhenInUseUsageDescription 這個 Key&Value
         * 說明為何要取得使用 App 期間授權的文字，這樣才能調用這個方法來取得 GPS 權限。
         */
        location.requestWhenInUseAuthorization()
        
        // 表示移動 10 公尺再更新座標資訊
        location.distanceFilter = CLLocationDistance(10)
        // 開始接收目前位置資訊
        location.startUpdatingLocation()
        
        /*let request = MKLocalSearch.Request()
         request.naturalLanguageQuery = "bank"
         request.region = MapView.region
         let Address: String?
         let ContactInformation: String
         let OpeningHours: String
         let BranchServices: Bool
         let Branch: String
         let Brand: String
         let BranchDefinition: Array<Any>
         let BranchDefinitionMeta: Array<Any>
         let coordinate: CLLocationCoordinate2D*/
        // show artwork on map
        //loadInitialData()
        //MapView.addAnnotations(bank)

    }
    /*func loadInitialData() {
      // 1
      guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
        else { return }
      let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

      guard
        let data = optionalData,
        // 2
        let json = try? JSONSerialization.jsonObject(with: data),
        // 3
        let dictionary = json as? [String: Any],
        // 4
        let works = dictionary["data"] as? [[Any]]
        else { return }
      // 5
      let validWorks = works.flatMap { Bank(json: $0) }
      bank.append(contentsOf: validWorks)
    }*/
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(search.text!){ (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                let placemark = placemarks?.first
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = self.search.text!
                
                let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
                let region = MKCoordinateRegion(center: anno.coordinate, span: span)
                
                self.MapView.setRegion(region, animated: true)
                self.MapView.addAnnotation(anno)
                self.MapView.selectAnnotation(anno, animated: true)
            }
    }
    }
    override func viewDidDisappear(_ animated: Bool) {
        // 因為 GPS 功能很耗電,所以背景執行時關閉定位功能
        location.stopUpdatingLocation();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 實作 CLLocationManagerDelegate 需要的委任方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 取得目前的座標位置
        let _curLocation = locations[0]
        
        // curLocation.coordinate.latitude 目前緯度
        // curLocation.coordinate.longitude 目前經度
        let _nowLocationCoordinate2D = CLLocationCoordinate2D(
            latitude: _curLocation.coordinate.latitude,
            longitude: _curLocation.coordinate.longitude
        )
        
        // _span 是地圖 zoom in, zoom out 的級距
        let _coordinateSpan: MKCoordinateSpan = MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
        
        // 將地圖中心點座標定位在目前所在的位置上
        self.MapView.setRegion(
            MKCoordinateRegion(
                center: _nowLocationCoordinate2D,
                span: _coordinateSpan
            ),
            animated: true
        )
        
        NSLog("latitude = \(_curLocation.coordinate.latitude)")
        NSLog("longitude = \(_curLocation.coordinate.longitude)")
        
        
        
    }
    
    
    func centerMapOnUserButtonClicked() {
        self.MapView.setUserTrackingMode( MKUserTrackingMode.follow, animated: true)
    }
    
    // 將經緯度轉成地址的方法
    /*private func reverseGeocodeLocation(_latitude: Double, _longitude: Double) -> Void {
     let geoCoder = CLGeocoder()
     let currentLocation = CLLocation(
     latitude: _latitude,
     longitude: _longitude
     )
     geoCoder.reverseGeocodeLocation(
     currentLocation, completionHandler: {
     (placemarks, error) -> Void in
     if error != nil {
     // 這邊可以加入一些你的 Try Error 機制
     return
     }
     /*  name            街道地址
     *  country         國家
     *  province        省籍
     *  locality        城市
     *  sublocality     縣市、區
     *  route           街道、路名
     *  streetNumber    門牌號碼
     *  postalCode      郵遞區號
     */
     if placemarks != nil && (placemarks?.count)! > 0{
     let placemark = (placemarks?[0])! as CLPlacemark
     //這邊拼湊轉回來的地址
     }
     }
     )
     }
     
     // 在地圖上新增一個大頭針的方法
     private func addPointAnnotation(_latitude: CLLocationDegrees , _longitude: CLLocationDegrees) {
     // 建構一個大頭針元件 MKPointAnnotation()
     let _pointAnnotation: MKPointAnnotation = MKPointAnnotation();
     // 定義大頭針的經緯度座標
     _pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude);
     // 定義大頭針顯示的標題
     _pointAnnotation.title = "大頭針標題";
     // 定義大頭針的內容訊息
     _pointAnnotation.subtitle = "緯度：\(_latitude) 經度:\(_longitude)";
     // 在地圖上新增大頭針座標
     self.MapView.addAnnotation(_pointAnnotation);
     }*/
    
}
/*extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Bank else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}*/

