//
//  InsightsItemViewController.swift
//  Group01Project
//
//  Created by Zensis on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class InsightsItemViewController: BaseViewController, UITabBarDelegate  {
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTabBar?.delegate = self
        // Do any additional setup after loading the view.
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           switch(tabBar.selectedItem?.title){
           case "Insights":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showInsights()
               break
           case "Home":
            self.dismiss(animated: false, completion: nil)
            rootRouter?.showHome()
           case .none:
                break
           case .some(_):
            break
        }
    }
}
