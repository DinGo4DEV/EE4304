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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabBar?.delegate = self
        // Do any additional setup after loading the view.
        let api:RestManager = RestManager.init()
        api.request_fxChange_HengSeng(){
            [weak self](result) in
            let json:HengSeng.FxRateJson = result as! HengSeng.FxRateJson
            let exchange = json.fxttExchangeRates as! [HengSeng.fxttExchangeRates]
//            print(json.fxttExchangeRates)
            print(exchange[0].ccyDisplayCode)
//                print(result)
//            print(result[0])
            }
        
//        var parma:HKMA.params = HKMA.params()
//        api.request_fxChange_HKMA(params: parma){
//                        [weak self](result) in
//                            print(result)
//        }
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
