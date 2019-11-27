//
//  InsightPressViewController.swift
//  Group01Project
//
//  Created by Au Yeung Tsz Wang on 27/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit
import WebKit

class InsightPressWebViewController: BaseViewController {
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    var url = "www.google.com"
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
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
