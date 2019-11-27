//
//  LoadViewController.swift
//  Group01Project
//
//  Created by kamtat ho on 28/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if(!checkJsonData {}){
            if(!isLoading()){
                startLoading()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func checkJsonData(Valied:@escaping(() -> Void) ) -> Bool{
        var valied:Bool = true
        if(RestManager.HengSengRateJson == nil){
            valied = false
        }
        if(RestManager.HKMARateJson == nil){
            valied = false
        }
        if(RestManager.HKMAEopJson == nil){
            valied = false
        }
        if(RestManager.HKMAMonthJson == nil){
            valied = false
        }
        if(RestManager.HengSengBranchJson == nil){
            valied = false
        }
        return valied
    }
    static var loaded = false
    
    func startLoading() {
        aView = UIView(frame: self.view.bounds)
        // Auto Layout Config
        let leading = NSLayoutConstraint(item: aView!, attribute: .leading,relatedBy: .equal,toItem: self.view, attribute: .leading,multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: aView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: aView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: aView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        aView?.backgroundColor = UIColor.init(red:0.5, green:0.5, blue:0.5, alpha: 0.5)
        
        aView?.translatesAutoresizingMaskIntoConstraints = false
        aView!.addSubview(loadingIndicator!)
        self.view.addSubview(aView!)
        aView?.center = self.view.center
        //Add AutoLayoutConfig to self
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
       loadingIndicator?.startAnimating()
       loadingIndicator?.isHidden = false
        BaseViewController.loaded = true
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
