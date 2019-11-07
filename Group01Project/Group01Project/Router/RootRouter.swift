//
//  RootRouter.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class RootRouter: Router{
    
    func showHome(animated: Bool, complete: (() -> Void)? = nil ){
        guard
          let homeViewController = UIStoryboard.storyboard(.main).instantiateViewController(HomeViewController.self) else {
            return
        }
//        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        homeViewController.router = self
        
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    func showTest(){
        guard
            let testViewController = UIStoryboard.storyboard(.main).instantiateViewController(TestViewController.self) else {
              return
          }
          
          testViewController.router = self
          
          navigationController?.pushViewController(testViewController, animated: true)
    }
}
