//
//  MainViewController.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var rootRouter: RootRouter? {
       return router as? RootRouter
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        navigationItem.leftItemsSupplementBackButton = false
        while(RestManager.HengSengRateJson == nil || RestManager.HKMARateJson == nil || RestManager.HengSengBranchJson == nil){
            if(!isLoading()){
                startLoading()
            }
        }
        if(isLoading()){
            stopLoading()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }


}
// Make your own VC inherit the BaseViewController
//if you need to use the tab view connect to the tabBar inside the baseViewController.swift
//if you dont need the tabBar just let it be, then it will disapear
