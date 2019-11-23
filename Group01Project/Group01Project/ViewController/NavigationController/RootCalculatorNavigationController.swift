//
//  RootCalculatorNavigationController.swift
//  Group01Project
//
//  Created by Zensis on 21/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class RootCalculatorNavigationController: UINavigationController {

    var router: RootRouter?
     
     override func viewDidLoad() {
        super.viewDidLoad()
        router = RootRouter(self)
        router?.showCalculators()
         // Do any additional setup after loading the view.
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
