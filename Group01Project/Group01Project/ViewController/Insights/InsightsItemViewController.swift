//
//  InsightsItemViewController.swift
//  Group01Project
//
//  Created by Zensis on 8/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit
import RealmSwift

class InsightsItemViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var insightButton: UIButton!
    @IBOutlet weak var pressButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    var viewModel : InsightViewModel?
    var tabStatus : Bool = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        viewModel?.syncData { [weak self] (failReason) in

                    if failReason != nil {
                      self?.showErrorAlert(reason: failReason, showCache: true) { _ in
                        // Fix AlertController conflict withRefresh Controll
        //                self?.viewModel.workspaceActivityList.value.removeAll()
                        self?.tableView.setContentOffset(CGPoint.zero, animated: true)
                      }
                    }

                    
                }
        viewModel?.updateData()
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InsightViewModel()
        startLoading()
        viewModel?.syncData { [weak self] (failReason) in

                    if failReason != nil {
                      self?.showErrorAlert(reason: failReason, showCache: true) { _ in
                        // Fix AlertController conflict withRefresh Controll
        //                self?.viewModel.workspaceActivityList.value.removeAll()
                        self?.tableView.setContentOffset(CGPoint.zero, animated: true)
                      }
                    }

                    self?.tableView.reloadData()
                }
        tableView.delegate = self
        tableView.dataSource = self
        stopLoading()
        uiBind()
        viewModel?.updateData()
        self.tableView.reloadData()
        //print(viewModel.insightList)
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
        self.tableView.reloadData()
    }
    
    
    @IBAction func pressClicked(_ sender: Any) {
        
        tabStatus.toggle()
        uiBind()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabStatus{
            return viewModel?.insightList?.count ?? 0
        }else{
            return viewModel?.pressList?.count ?? 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InsightPressTableViewCell", for: indexPath) as? InsightPressTableViewCell else {
            return UITableViewCell()
        }
        if tabStatus{
            let tempInsightPress = viewModel?.insightList?[indexPath.row]
            cell.uiBind(insight: tempInsightPress!)
        }else{
            let tempInsightPress = viewModel?.pressList?[indexPath.row]
            cell.uiBind(press: tempInsightPress!)
        }
        return cell
    }
}

class InsightViewModel{
    var insightRecord : Results<InsightResponse>?
    var insightList : List<Insight>?
    
    var pressRecord : Results<PressResponse>?
    var pressList : List<Press>?
    
    init(){
        insightRecord = try? Realm().objects(InsightResponse.self)
        insightList?.removeAll()
        insightList = insightRecord?.first?.records
        
        pressRecord = try? Realm().objects(PressResponse.self)
        pressList?.removeAll()
        pressList = pressRecord?.first?.records
    }
    
    func updateData(){
        
        insightRecord = try? Realm().objects(InsightResponse.self)
        
        insightList = insightRecord?.first?.records
        
        pressRecord = try? Realm().objects(PressResponse.self)
        
        pressList = pressRecord?.first?.records
    }
    
    func syncData(completed: ((SyncDataFailReason?) -> Void)?) {
        if SyncData.firstSync{
            SyncData().syncInsight(completed: completed)
            SyncData().syncPress(completed: completed)
        }else{
            SyncData().firstSync(completed: completed)
            SyncData.firstSync = true
        }
    }
}
