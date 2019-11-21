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
    
    
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?

    
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
    
   
}

