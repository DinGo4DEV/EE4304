//
//  BaseNavigationController.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
      var router: Router? {
        didSet {
          // Pass the router into TopViewController
          if let topVC = topViewController as? BaseViewController {
            topVC.router = router
          }
            
        }
      }

      override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = true
        
      }

      override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
      }
    }
