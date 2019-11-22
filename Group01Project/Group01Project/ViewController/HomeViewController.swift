//
//  MainViewController.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITabBarDelegate {
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
        self.mainTabBar?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           switch(tabBar.selectedItem?.title){
           case "Insights":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showInsights()
               break
           case "Calculator":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showCalculators()
            break
           case .none:
                break
           case .some(_):
            break
        }
    }

}
// Make your own VC inherit the BaseViewController
//if you need to use the tab view connect to the tabBar inside the baseViewController.swift
//if you dont need the tabBar just let it be, then it will disapear
