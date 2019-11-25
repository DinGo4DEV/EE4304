//
//  InsightsItemViewController.swift
//  Group01Project
//
//  Created by Zensis on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class InsightsItemViewController: BaseViewController  {
    
    @IBOutlet weak var insightButton: UIButton!
    @IBOutlet weak var pressButton: UIButton!
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    var tabStatus : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiBind()
        // Do any additional setup after loading the view.
    }
    
    func uiBind(){
        if tabStatus{
            insightButton.isUserInteractionEnabled = false
            pressButton.isUserInteractionEnabled = true
            insightButton.backgroundColor = UIColor.init(red: 74, green: 144, blue: 226)
            pressButton.backgroundColor = UIColor.init(red: 190, green: 190, blue: 190)
        }else{
            pressButton.backgroundColor = UIColor.init(red: 74, green: 144, blue: 226)
            insightButton.backgroundColor = UIColor.init(red: 190, green: 190, blue: 190)
            insightButton.isUserInteractionEnabled = true
            pressButton.isUserInteractionEnabled = false
        }
        
    }

    @IBAction func insightClicked(_ sender: Any) {
        
        tabStatus.toggle()
        uiBind()
    }
    
    @IBAction func pressClicked(_ sender: Any) {
        
        tabStatus.toggle()
        uiBind()
    }
}
