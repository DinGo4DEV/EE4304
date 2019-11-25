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
    
    var apiManager = RestManager.init()
    
    
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView?
    
    
    override func loadView() {
        super.loadView()
        DispatchQueue.main.async {
            if(RestManager.HengSengRateJson==nil){
                self.apiManager.request_fxnoteExchangeRates_HengSeng(){
                    [weak self] (result) in
                    RestManager.HengSengRateJson = result as? HengSeng.FxRateJson
                    if(self!.isLoading()){
                        if(self!.checkJsonData() { () in}){
                            self!.stopLoading()
                        }
                    }
                    
                }
            }
            
            if(RestManager.HKMARateJson == nil){
                var parma:HKMA.params = HKMA.params()
                self.apiManager.request_fxChange_HKMA(params: parma){
                    [weak self](result) in
                    RestManager.HKMARateJson = result as? HKMA.FxRateJson
                    do{
                        
                    } catch {
                        print("Can't to JSON")
                    }
                    if(self!.isLoading()){
                        if(self!.checkJsonData() { () in}){
                            self!.stopLoading()
                        }
                    }
                }
            }
            
            if(RestManager.HengSengBranchJson == nil){
                self.apiManager.request_Branch_HengSeng(){
                    [weak self] (result) in
                    RestManager.HengSengBranchJson = result as? HengSeng.branchJson
                    if(self!.isLoading()){
                        if(self!.checkJsonData() { () in}){
                            self!.stopLoading()
                        }
                    }
                }
            }
            if(RestManager.HKMAEopJson == nil){
                self.apiManager.request_month_HKMA(){
                    [weak self] (result) in
                    RestManager.HKMAMonthJson = result as? HKMA.MonthJson
                    if(self!.isLoading()){
                        if(self!.checkJsonData() { () in}){
                            self!.stopLoading()
                        }
                    }
                }
            }
            if(RestManager.HKMAEopJson == nil){
                self.apiManager.request_eop_HKMA(){
                    [weak self] (result) in
                    RestManager.HKMAEopJson = result as? HKMA.MonthJson
                    if(self!.isLoading()){
                        if(self!.checkJsonData() { () in}){
                            self!.stopLoading()
                        }
                    }
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        // Do any additional setup after loading the view.
        loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator!.center = self.view.center
        if(!checkJsonData {}){
            if(!isLoading()){
                startLoading()
            }
        }
        //        self.view.addSubview(loadingIndicator!)
    }
    
    
    fileprivate var aView: UIView?
    
    func checkJsonData(Valied:@escaping(() -> Void) ) -> Bool{
        var valied:Bool = true
        if(RestManager.HengSengRateJson == nil){
            valied = false
        }
        if(RestManager.HKMARateJson == nil){
            valied = false
        }
        if(RestManager.HengSengBranchJson == nil){
            valied = false
        }
        return valied
    }
    static var loaded = false
    
    func startLoading() {
        aView = UIView(frame: self.view.bounds)
        // Auto Layout Config
        let leading = NSLayoutConstraint(item: aView!, attribute: .leading,relatedBy: .equal,toItem: self.view, attribute: .leading,multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: aView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: aView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: aView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        aView?.backgroundColor = UIColor.init(red:0.5, green:0.5, blue:0.5, alpha: 0.5)
        
        aView?.translatesAutoresizingMaskIntoConstraints = false
        aView!.addSubview(loadingIndicator!)
        self.view.addSubview(aView!)
        aView?.center = self.view.center
        //Add AutoLayoutConfig to self
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        loadingIndicator?.startAnimating()
        loadingIndicator?.isHidden = false
        BaseViewController.loaded = true
    }
    
    
    func stopLoading() {
        //        UI View need to be called on Main thread
        DispatchQueue.main.async {
            self.loadingIndicator?.isHidden = true
            self.aView?.removeFromSuperview()
            BaseViewController.loaded = false
        }
        
    }
    
    
    
    func isLoading() -> Bool {
        //        UI View need to be called on Main thread
        //        DispatchQueue.main.async {
        //            bool = !(self.loadingIndicator?.isHidden ?? true)
        //        }
        return BaseViewController.loaded
    }
    
    
}

