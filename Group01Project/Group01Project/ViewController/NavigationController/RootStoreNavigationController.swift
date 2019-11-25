//
//  RootStoreNavigationController.swift
//  Group01Project
//
//  Created by Stanley on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class RootStoreNavigationController: UINavigationController {

    var router: RootRouter?
    
    override func viewDidLoad() {
       super.viewDidLoad()
       router = RootRouter(self)
       router?.showStores()
        // Do any additional setup after loading the view.
    }
}
