//
//  ViewController.swift
//  Group01Project
//
//  Created by Stanley on 10/9/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var router: Router?
        
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

