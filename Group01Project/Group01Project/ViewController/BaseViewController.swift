//
//  ViewController.swift
//  Group01Project
//
//  Created by Stanley on 10/9/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var clearColorNavigationBar: Bool = false
    var hideNavigationBarShadow: Bool = false
    var router: Router?
    var tabBarItems: [UITabBarItem]?
    var itemName = ["Rate", "Calculator", "Home", "Insights", "Stores"]
    var itemImage = [UIImage(named: "money-black"),UIImage(named: "calculator-black"),UIImage(named: "home-black"),UIImage(named: "search-black"),UIImage(named: "stores-black")]
    var apiManager = RestManager.init()
    
    
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var mainTabBar: UITabBar?
    
    override func loadView() {
        super.loadView()
        if(RestManager.jsonHengSeng==nil){
            apiManager.request_fxnoteExchangeRates_HengSeng(){
                [weak self] (result) in
                RestManager.jsonHengSeng = result as? HengSeng.FxRateJson
            }
        }
        
        if(RestManager.jsonHKMA == nil){
            var parma:HKMA.params = HKMA.params()
            apiManager.request_fxChange_HKMA(params: parma){
                [weak self](result) in
                RestManager.jsonHKMA = result as? HKMA.FxRateJson
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        navigationItem.leftItemsSupplementBackButton = true
        // Do any additional setup after loading the view.
    }
    

    func startLoading() {
       loadingIndicator?.startAnimating()
       loadingIndicator?.isHidden = false
     }

     func stopLoading() {
       loadingIndicator?.isHidden = true
     }

     func isLoading() -> Bool {
       return !(loadingIndicator?.isHidden ?? true)
     }
    
    func setUpTabBar(){
        var index:Int = 0;
        for item in itemName{
            mainTabBar?.items?.append(UITabBarItem.init(title: item, image: itemImage[index], selectedImage: UIImage.init(named: "tray.fill")))
            index += 1
               
        }
    }
    
   
}

