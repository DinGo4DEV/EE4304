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
    
    
  @IBOutlet var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var mainTabBar: UITabBar?
    
    override func loadView() {
        super.loadView()
        if(RestManager.HengSengRateJson==nil){
            apiManager.request_fxnoteExchangeRates_HengSeng(){
                [weak self] (result) in
                RestManager.HengSengRateJson = result as? HengSeng.FxRateJson
            }
        }
        
        if(RestManager.HKMARateJson == nil){
            var parma:HKMA.params = HKMA.params()
            apiManager.request_fxChange_HKMA(params: parma){
                [weak self](result) in
                RestManager.HKMARateJson = result as? HKMA.FxRateJson
            }
        }
        
        if(RestManager.HengSengBranchJson == nil){
            apiManager.request_Branch_HengSeng(){
                [weak self] (result) in
                RestManager.HengSengBranchJson = result as? HengSeng.branchJson
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        navigationItem.leftItemsSupplementBackButton = true
        // Do any additional setup after loading the view.
        loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator!.center = self.view.center
//        self.view.addSubview(loadingIndicator!)
    }
    
    
    fileprivate var aView: UIView?
    
    func checkJsonData(Valied:@escaping(() -> Void) ){
        if(!isLoading()){
            startLoading()
            self.view.layoutIfNeeded()
        }
        while(RestManager.HengSengRateJson == nil || RestManager.HKMARateJson == nil || RestManager.HengSengBranchJson == nil){
//            if(!isLoading()){
//                startLoading()
//                self.view.layoutIfNeeded()
            print("Api is nil")
            }
//        }
            Valied()
    }

    func startLoading() {
        aView = UIView(frame: self.view.bounds)
        // Auto Layout Config
        let leading = NSLayoutConstraint(item: aView!, attribute: .leading,relatedBy: .equal,toItem: self.view, attribute: .leading,multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: aView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: aView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: aView!, attribute: .bottom, relatedBy: .equal, toItem: self.mainTabBar, attribute: .top, multiplier: 1.0, constant: 0)
        
        aView?.backgroundColor = UIColor.init(red:0.5, green:0.5, blue:0.5, alpha: 0.5)
        
        aView?.translatesAutoresizingMaskIntoConstraints = false
        aView!.addSubview(loadingIndicator!)
        self.view.addSubview(aView!)
        aView?.center = self.view.center
        //Add AutoLayoutConfig to self
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
       loadingIndicator?.startAnimating()
       loadingIndicator?.isHidden = false
     }

     func stopLoading() {
       loadingIndicator?.isHidden = true
        aView?.removeFromSuperview()
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

