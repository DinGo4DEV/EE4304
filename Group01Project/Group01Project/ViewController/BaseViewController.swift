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
    
    
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var mainTabBar: UITabBar?
    
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
        for item in itemName{
            mainTabBar?.items?.append(UITabBarItem.init(title: item, image: UIImage.init(named: "tray"), selectedImage: UIImage.init(named: "tray.fill")))
               
        }
    }
    
   
}

