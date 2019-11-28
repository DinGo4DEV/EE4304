//
//  MainViewController.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    let currencyName = ["usd", "gbp" , "jpy","cad","twd","cny","eur"]
    @IBOutlet weak var currencyTableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    var viewModel = HomeViewModel()
    
    var rootRouter: RootRouter? {
      return router as? RootRouter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        if(!isLoading()){
//            startLoading()
//        }
        UIBind()
        viewModel.loadData()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        
        currencyTableView.reloadData()
    }
    
    override func loadView() {
        
            super.loadView()
            viewModel.loadData()
        
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        rootRouter?.showTest()
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        viewModel.loadData()
            
            currencyTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeRateTableViewCell", for: indexPath) as! HomeRateTableViewCell
        // Basic Cell
        //        cell.textLabel?.text = restaurants[indexPath.row].name
        //        cell.imageView?.image = UIImage(named: restaurants[indexPath.row].image)
        // Custom Cell
//
//        guard let value = viewModel.currencyArray.value(for: currencyName[indexPath.row]) as? Double? else {
//            viewModel.loadData()
//            return UITableViewCell()
//        }
        guard let tempCurr = (viewModel.currencyArray.filter{$0.name == currencyName[indexPath.row].uppercased()}).first else {
            self.viewModel.loadData()
            return UITableViewCell()
        }
        print(viewModel.currencyArray.filter{$0.name == currencyName[indexPath.row].uppercased()})
        cell.exchangeCurr.text = "1 " + currencyName[indexPath.row].uppercased()
        cell.baseCurr.text = "\(tempCurr.rate!) HKD"
        cell.baseCountry.image = UIImage.init(named: "hkd")
        cell.exchangeCountry.image = UIImage.init(named: currencyName[indexPath.row])
        cell.isUserInteractionEnabled = false
        return cell
    }

    
    func UIBind(){
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "dd MMM, yyyy"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E"
        let date = NSDate()
        dateLabel.text = dateFormatterDay.string(for: date)
        dayLabel.text = dateFormatterPrint.string(for: date)
        refreshButton.backgroundColor = UIColor.init(red: 74, green: 144, blue: 226)
        
    }

}


// Make your own VC inherit the BaseViewController
//if you need to use the tab view connect to the tabBar inside the baseViewController.swift
//if you dont need the tabBar just let it be, then it will disapear

class  HomeViewModel{
    
    var currencyArray = [Currency]()
    
    init(){
        loadData()
        currencyArray.removeAll()
//        loadCurrFromArray()
    }
    
    func loadData(){
        if(RestManager.HKMARateJson == nil){
            var  apiManager = RestManager.init()
            var parma:HKMA.params = HKMA.params()
            apiManager.request_fxChange_HKMA(params: parma){
                [weak self](result) in
                RestManager.HKMARateJson = result as? HKMA.FxRateJson
                //self?.loadCurrFromArray()
            }
            
        }
        loadCurrFromArray()
    }
    
    func loadCurrFromArray(){
        currencyArray.removeAll()
        
        currencyArray.append(Currency(name:"USD" ,rate: RestManager.HKMARateJson?
            .result?.records![0].usd ?? 0.0))
        currencyArray.append(Currency(name:"GBP" ,rate: RestManager.HKMARateJson?.result?.records![0].gbp ?? 0.0))
        currencyArray.append(Currency(name:"JPY" , rate:RestManager.HKMARateJson?.result?.records![0].jpy ?? 0.0))
        currencyArray.append(Currency(name:"CAD" , rate:RestManager.HKMARateJson?.result?.records![0].cad ?? 0.0))
        currencyArray.append(Currency(name:"AUD" , rate:RestManager.HKMARateJson?.result?.records![0].aud ?? 0.0))
        currencyArray.append(Currency(name:"SGD", rate:RestManager.HKMARateJson?.result?.records![0].sgd ?? 0.0))
        currencyArray.append(Currency(name:"TWD" , rate:RestManager.HKMARateJson?.result?.records![0].twd ?? 0.0))
        currencyArray.append(Currency(name:"CHF" , rate:RestManager.HKMARateJson?.result?.records![0].chf ?? 0.0))
        currencyArray.append(Currency(name:"CNY" , rate:RestManager.HKMARateJson?.result?.records![0].cny ?? 0.0))
        currencyArray.append(Currency(name:"KRW" , rate:RestManager.HKMARateJson?.result?.records![0].krw ?? 0.0))
        currencyArray.append(Currency(name:"THB" , rate:RestManager.HKMARateJson?.result?.records![0].thb ?? 0.0))
        currencyArray.append(Currency(name:"MYR" , rate:RestManager.HKMARateJson?.result?.records![0].myr ?? 0.0))
        currencyArray.append(Currency(name:"EUR" , rate:RestManager.HKMARateJson?.result?.records![0].eur ?? 0.0))
        currencyArray.append(Currency(name:"PHP" , rate:RestManager.HKMARateJson?.result?.records![0].php ?? 0.0))
        currencyArray.append(Currency(name:"INR" , rate:RestManager.HKMARateJson?.result?.records![0].inr ?? 0.0))
        currencyArray.append(Currency(name:"HKD" , rate:1))
    }
    
}


extension Currency {
    
    func hasKey(for path: String) -> Bool {
        return dictionary?[path] != nil
    }
    func value(for path: String) -> Double? {
        return dictionary?[path] as? Double
    }
    var dictionary: [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any]
    }
    
}
