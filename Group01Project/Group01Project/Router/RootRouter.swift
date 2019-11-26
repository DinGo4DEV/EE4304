//
//  RootRouter.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class RootRouter: Router{
    
    
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
    
    func showStores(){
        guard
            let StoreViewController = UIStoryboard.storyboard(.stores).instantiateViewController(StoreViewController.self) else {
                return
        }
        StoreViewController.router = self
        navigationController?.pushViewController(StoreViewController, animated: true)
    }
    
    func showRate(){
        guard
            let rateViewController = UIStoryboard.storyboard(.rate).instantiateViewController(RateViewController.self) else {
                return
        }
        rateViewController.router = self
        navigationController?.pushViewController(rateViewController, animated: true)
    }
}
