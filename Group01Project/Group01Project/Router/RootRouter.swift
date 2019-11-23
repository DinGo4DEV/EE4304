//
//  RootRouter.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class RootRouter: Router{
    
    //Root router is the router showing the 5 core viewController
    // Open the 5 other routers for routing in those 5 tabs
    
    func showStart(animated: Bool, complete: (() -> Void)? = nil ){
        guard
          let homeViewController = UIStoryboard.storyboard(.main).instantiateViewController(HomeViewController.self) else {
            return
        }
//        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        homeViewController.router = self
        homeViewController.modalPresentationStyle = .fullScreen
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
//    func showHome(){
//           guard
//               let homeViewController = UIStoryboard.storyboard(.main).instantiateViewController(HomeViewController.self) else {
//                 return
//             }
////             homeViewController.modalPresentationStyle = .fullScreen
//             homeViewController.router = self
//
//        navigationController?.popViewController(animated: true)
//       }
    
    func showInsights(){
        guard
            let insightViewController = UIStoryboard.storyboard(.insights).instantiateViewController(InsightsItemViewController.self) else {
              return
          }
   

          insightViewController.router = self
        navigationController?.pushViewController(insightViewController, animated: false)

    }
    
    func showCalculators(){
        guard
            let CalculatorViewController = UIStoryboard.storyboard(.calculator).instantiateViewController(CalculatorViewController.self) else {
                return
        }
        CalculatorViewController.router = self
        navigationController?.pushViewController(CalculatorViewController, animated: true)
    }
}
