//
//  InsightsItemViewController.swift
//  Group01Project
//
//  Created by Zensis on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class InsightsItemViewController: BaseViewController  {
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }
}
