//
//  RootRateNavigationController.swift
//  Group01Project
//
//  Created by AnimaeTech-MacMini2018 on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
import UIKit

class RootRateNavigationController: UINavigationController {

    var router: RootRouter?
    
    override func viewDidLoad() {
       super.viewDidLoad()
       router = RootRouter(self)
       router?.showRate()
        // Do any additional setup after loading the view.
    }
}
