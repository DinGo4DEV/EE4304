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

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    var location : CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "bank"
        request.region = MapView.region
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


