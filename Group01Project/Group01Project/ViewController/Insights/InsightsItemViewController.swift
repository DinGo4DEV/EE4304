//
//  InsightsItemViewController.swift
//  Group01Project
//
//  Created by Zensis on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit
import RealmSwift

class InsightsItemViewController: BaseViewController  {
    
    @IBOutlet weak var insightButton: UIButton!
    @IBOutlet weak var pressButton: UIButton!
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    var viewModel = InsightViewModel()
    var tabStatus : Bool = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.syncData { [weak self] (failReason) in
        
            if failReason != nil {
              self?.showErrorAlert(reason: failReason, showCache: true) { _ in
                // Fix AlertController conflict withRefresh Controll
    //                self?.viewModel.workspaceActivityList.value.removeAll()
    //                self?.tableView.setContentOffset(CGPoint.zero, animated: true)
              }
            }
          }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.syncData { [weak self] (failReason) in
//
//            if failReason != nil {
//              self?.showErrorAlert(reason: failReason, showCache: true) { _ in
//                // Fix AlertController conflict withRefresh Controll
////                self?.viewModel.workspaceActivityList.value.removeAll()
////                self?.tableView.setContentOffset(CGPoint.zero, animated: true)
//              }
//            }
//          }
        uiBind()
        print(viewModel.insightList?.first as Any)
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

class InsightViewModel{
    var insightRecord : Results<InsightResponse>?
//    var insightList : List<Insight>?
    var insightList: [Insight]?
    init(){
        insightRecord = try? Realm().objects(InsightResponse.self)
        insightList = insightRecord?[0].result!.records
        print(insightRecord)
    }
    
    func syncData(completed: ((SyncDataFailReason?) -> Void)?) {
        SyncData().syncInsight(completed: completed)
    }
}
