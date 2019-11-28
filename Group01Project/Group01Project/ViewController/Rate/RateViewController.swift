//
//  RateViewController.swift
//  Group01Project
//
//  Created by Vincent on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//


import UIKit

class RateViewController: BaseViewController, UITabBarDelegate ,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var selectedDollar: String?
    var toolbar = UIToolbar()
    var picker  = UIPickerView()
    var selectedIndex = 15
    //var dollarList = ["USD","","","","",""]
    var selectedTap = 1
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tableData[0].currency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tableData[0].currency[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //selectedDollar = tableData[0].currency[row].name // selected item
        //currecylabel.text = selectedDollar
    }
    
    
    
    @IBAction func currecyonlclick(_ sender: Any) {
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolbar.barStyle = .default
        currencypicker.isEnabled = false
        toolbar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolbar)
        
        
    }
    
    
    @objc func onDoneButtonTapped() {
        selectedIndex = picker.selectedRow(inComponent: 0)
        
        
        
        currecylabel.text =  tableData[0].currency[selectedIndex].name
        swap()
        if (selectedTap == 1){
            tableData = temp.dailyrate
        }
        else if (selectedTap == 2)
        {
            tableData = temp.monthrate
        }
        else {
            tableData = temp.eoprate
        }
        ratetable.reloadData()
        toolbar.removeFromSuperview()
        picker.removeFromSuperview()
        currencypicker.isEnabled = true
        
    }
    
    
    var temp : Rate = Rate(dailyrate: [],monthrate: [],eoprate: [])
    var tableData  = [Date]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableData.count == 0){
            return 0
        }
        else {return tableData[0].currency.count-1}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rate", for: indexPath) as? RateTableViewCell else {
            return UITableViewCell()
        }
        //        if(RestManager.HKMARateJson == nil){
        //            var parma:HKMA.params = HKMA.params()
        //            apiManager.request_fxChange_HKMA(params: parma){
        //                [weak self](result) in
        //                RestManager.HKMARateJson = result as? HKMA.FxRateJson
        //
        //            }
        //
        //        }
        //        if (dict1.count == 0){
        //            input()
        //        }
        
        cell.currency.text = tableData[0].currency[indexPath.row].name
        cell.rate.text = String(format:"%.3f",(tableData[0].currency[indexPath.row].rate!/tableData[0].currency[15].rate!))
        if (tableData[0].currency[indexPath.row].rate! > tableData[1].currency[indexPath.row].rate!){
            if #available(iOS 13.0, *) {
                cell.arrow.image = UIImage(systemName: "arrowtriangle.up.fill")
            } else {
                // Fallback on earlier versions
            }
        
            cell.arrow.tintColor = UIColor.green
            
        }
        else if (tableData[0].currency[indexPath.row].rate! == tableData[1].currency[indexPath.row].rate!){
            if #available(iOS 13.0, *) {
                cell.arrow.image = UIImage(systemName: "minus")
            } else {
                // Fallback on earlier versions
            }
        
            cell.arrow.tintColor = UIColor.gray
            
        }
        else {
            if #available(iOS 13.0, *) {
                cell.arrow.image = UIImage(systemName: "arrowtriangle.down.fill")
            } else {
                // Fallback on earlier versions
            }
       
            cell.arrow.tintColor = UIColor.red
        }
//        if (indexPath.row % 2 == 0) {
//            cell.backgroundColor = UIColor.lightGray
//        }
//        else {cell.backgroundColor = UIColor.white}
        return cell
        
    }
    func swap(){
        for i in temp.dailyrate{
            i.currency.swapAt(selectedIndex, 15)
        }
        for i in temp.monthrate{
            i.currency.swapAt(selectedIndex, 15)
        }
        for i in temp.eoprate{
            i.currency.swapAt(selectedIndex, 15)
        }
        
    }
    
    var rootRouter: RootRouter? {
        return router as? RootRouter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("appear")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("didload")
        daybutton.backgroundColor = UIColor.gray
        monthbutton.backgroundColor = UIColor.white
        eopbutton.backgroundColor = UIColor.white
        daybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        monthbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        eopbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        //print(temp.dailyrate.count)
        
        LoadDaily()
        LoadAverage()
        LoadEop()
        
        tableData = temp.dailyrate
        if(RestManager.HKMARateJson == nil){
            currecylabel.text = "HKD"
        }
        else {currecylabel.text =  tableData[0].currency[selectedIndex].name}
        
        ratetable.reloadData()
        // ratetable.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        print("loaddata")
        //temp = UserProfileCache.get("rate")
        //tableData = temp.dailyrate
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? ChartViewController
        let indexPath = self.ratetable.indexPathForSelectedRow
        controller?.data = temp
        controller?.base = tableData[0].currency[15].name
        controller?.target = tableData[0].currency[indexPath!.row].name
        controller?.index = indexPath!.row
        
        //        controller?.storeName = food[indexPath!.row].name
        //        controller?.information  = food[indexPath!.row].information
        //        controller?.theMenu = food[indexPath!.row].theMenu
        //        controller?.storeMap = food[indexPath!.row].storeMap
    }
    
    
    
    func LoadDaily(){
        
        print("LoadDaily")
        // let count = RestManager.HKMARateJson.result?.datasize as! Int
        if (RestManager.HKMAMonthJson != nil) {
               print("LoadDaily")
            for i in 0...6 {
                
                var dict1 = [Currency]()
                
                dict1.append(Currency(name:"USD" ,rate: RestManager.HKMARateJson
                    .result?.records![i].usd ?? 0.0))
                dict1.append(Currency(name:"GBP" ,rate: RestManager.HKMARateJson.result?.records![i].gbp ?? 0.0))
                dict1.append(Currency(name:"JPY" , rate:RestManager.HKMARateJson.result?.records![i].jpy ?? 0.0))
                dict1.append(Currency(name:"CAD" , rate:RestManager.HKMARateJson.result?.records![i].cad ?? 0.0))
                dict1.append(Currency(name:"AUD" , rate:RestManager.HKMARateJson.result?.records![i].aud ?? 0.0))
                dict1.append(Currency(name:"SGD", rate:RestManager.HKMARateJson.result?.records![i].sgd ?? 0.0))
                dict1.append(Currency(name:"TWD" , rate:RestManager.HKMARateJson.result?.records![i].twd ?? 0.0))
                dict1.append(Currency(name:"CHF" , rate:RestManager.HKMARateJson.result?.records![i].chf ?? 0.0))
                dict1.append(Currency(name:"CNY" , rate:RestManager.HKMARateJson.result?.records![i].cny ?? 0.0))
                dict1.append(Currency(name:"KRW" , rate:RestManager.HKMARateJson.result?.records![i].krw ?? 0.0))
                dict1.append(Currency(name:"THB" , rate:RestManager.HKMARateJson.result?.records![i].thb ?? 0.0))
                dict1.append(Currency(name:"MYR" , rate:RestManager.HKMARateJson.result?.records![i].myr ?? 0.0))
                dict1.append(Currency(name:"EUR" , rate:RestManager.HKMARateJson.result?.records![i].eur ?? 0.0))
                dict1.append(Currency(name:"PHP" , rate:RestManager.HKMARateJson.result?.records![i].php ?? 0.0))
                dict1.append(Currency(name:"INR" , rate:RestManager.HKMARateJson.result?.records![i].inr ?? 0.0))
                dict1.append(Currency(name:"HKD" , rate:1))
                //print ("test" + (RestManager.HKMARateJson.result?.records![i].end_of_day)! ?? "")
                // print(temp.dailyrate.count)
                temp.dailyrate.append(Date(date: (RestManager.HKMARateJson.result?.records![i].end_of_day)!  , currency: dict1))
                
                
            }
            for i in 2...3 {
                var dict1 = [Currency]()
                dict1.append(Currency(name:"USD" ,rate: RestManager.HKMARateJson
                    .result?.records![i*7-1].usd ?? 0.0))
                dict1.append(Currency(name:"GBP" ,rate: RestManager.HKMARateJson.result?.records![i*7-1].gbp ?? 0.0))
                dict1.append(Currency(name:"JPY" , rate:RestManager.HKMARateJson.result?.records![i*7-1].jpy ?? 0.0))
                dict1.append(Currency(name:"CAD" , rate:RestManager.HKMARateJson.result?.records![i*7-1].cad ?? 0.0))
                dict1.append(Currency(name:"AUD" , rate:RestManager.HKMARateJson.result?.records![i*7-1].aud ?? 0.0))
                dict1.append(Currency(name:"SGD", rate:RestManager.HKMARateJson.result?.records![i*7-1].sgd ?? 0.0))
                dict1.append(Currency(name:"TWD" , rate:RestManager.HKMARateJson.result?.records![i*7-1].twd ?? 0.0))
                dict1.append(Currency(name:"CHF" , rate:RestManager.HKMARateJson.result?.records![i*7-1].chf ?? 0.0))
                dict1.append(Currency(name:"CNY" , rate:RestManager.HKMARateJson.result?.records![i*7-1].cny ?? 0.0))
                dict1.append(Currency(name:"KRW" , rate:RestManager.HKMARateJson.result?.records![i*7-1].krw ?? 0.0))
                dict1.append(Currency(name:"THB" , rate:RestManager.HKMARateJson.result?.records![i*7-1].thb ?? 0.0))
                dict1.append(Currency(name:"MYR" , rate:RestManager.HKMARateJson.result?.records![i*7-1].myr ?? 0.0))
                dict1.append(Currency(name:"EUR" , rate:RestManager.HKMARateJson.result?.records![i*7-1].eur ?? 0.0))
                dict1.append(Currency(name:"PHP" , rate:RestManager.HKMARateJson.result?.records![i*7-1].php ?? 0.0))
                dict1.append(Currency(name:"INR" , rate:RestManager.HKMARateJson.result?.records![i*7-1].inr ?? 0.0))
                dict1.append(Currency(name:"HKD" , rate:1))
                temp.dailyrate.append(Date(date:RestManager.HKMARateJson.result?.records![i*7-1].end_of_day ?? "" , currency: dict1))
            }
            //        for i in temp.dailyrate{
            //            print(i.date)
        }
    }
    
    func LoadAverage(){
        
        if (RestManager.HKMAMonthJson != nil) {
            print("LoadAverage")
            //  let count = RestManager.HKMAMonthJson.result?.datasize as! Int ?? 0
            for i in 0...5 {
                var dict1 = [Currency]()
                dict1.append(Currency(name:"USD" ,rate: RestManager.HKMAMonthJson
                    .result?.records![i].usd ?? 0.0))
                dict1.append(Currency(name:"GBP" ,rate: RestManager.HKMAMonthJson.result?.records![i].gbp ?? 0.0))
                dict1.append(Currency(name:"JPY" , rate:RestManager.HKMAMonthJson.result?.records![i].jpy ?? 0.0))
                dict1.append(Currency(name:"CAD" , rate:RestManager.HKMAMonthJson.result?.records![i].cad ?? 0.0))
                dict1.append(Currency(name:"AUD" , rate:RestManager.HKMAMonthJson.result?.records![i].aud ?? 0.0))
                dict1.append(Currency(name:"SGD", rate:RestManager.HKMAMonthJson.result?.records![i].sgd ?? 0.0))
                dict1.append(Currency(name:"TWD" , rate:RestManager.HKMAMonthJson.result?.records![i].twd ?? 0.0))
                dict1.append(Currency(name:"CHF" , rate:RestManager.HKMAMonthJson.result?.records![i].chf ?? 0.0))
                dict1.append(Currency(name:"CNY" , rate:RestManager.HKMAMonthJson.result?.records![i].cny ?? 0.0))
                dict1.append(Currency(name:"KRW" , rate:RestManager.HKMAMonthJson.result?.records![i].krw ?? 0.0))
                dict1.append(Currency(name:"THB" , rate:RestManager.HKMAMonthJson.result?.records![i].thb ?? 0.0))
                dict1.append(Currency(name:"MYR" , rate:RestManager.HKMAMonthJson.result?.records![i].myr ?? 0.0))
                dict1.append(Currency(name:"EUR" , rate:RestManager.HKMAMonthJson.result?.records![i].eur ?? 0.0))
                dict1.append(Currency(name:"PHP" , rate:RestManager.HKMAMonthJson.result?.records![i].php ?? 0.0))
                dict1.append(Currency(name:"INR" , rate:RestManager.HKMAMonthJson.result?.records![i].inr ?? 0.0))
                dict1.append(Currency(name:"HKD" , rate:1))//
                temp.monthrate.append(Date(date:RestManager.HKMAMonthJson.result?.records![i].end_of_month ?? "" , currency: dict1))
                print("date: \(RestManager.HKMAMonthJson.result?.records![i].end_of_month) " + " rate:  \(temp.monthrate[i].currency[1].rate)")
                
            }
        }
        
        
    }
    func LoadEop(){
        
        if (RestManager.HKMAEopJson != nil) {
            print("LoadEop")
            // let count = RestManager.HKMAEopJson.result?.datasize as! Int ?? 0
            for i in 0...1 {
                var dict1 = [Currency]()
                dict1.append(Currency(name:"USD" ,rate: RestManager.HKMAEopJson
                    .result?.records![i].usd ?? 0.0))
                dict1.append(Currency(name:"GBP" ,rate: RestManager.HKMAEopJson.result?.records![i].gbp ?? 0.0))
                dict1.append(Currency(name:"JPY" , rate:RestManager.HKMAEopJson.result?.records![i].jpy ?? 0.0))
                dict1.append(Currency(name:"CAD" , rate:RestManager.HKMAEopJson.result?.records![i].cad ?? 0.0))
                dict1.append(Currency(name:"AUD" , rate:RestManager.HKMAEopJson.result?.records![i].aud ?? 0.0))
                dict1.append(Currency(name:"SGD", rate:RestManager.HKMAEopJson.result?.records![i].sgd ?? 0.0))
                dict1.append(Currency(name:"TWD" , rate:RestManager.HKMAEopJson.result?.records![i].twd ?? 0.0))
                dict1.append(Currency(name:"CHF" , rate:RestManager.HKMAEopJson.result?.records![i].chf ?? 0.0))
                dict1.append(Currency(name:"CNY" , rate:RestManager.HKMAEopJson.result?.records![i].cny ?? 0.0))
                dict1.append(Currency(name:"KRW" , rate:RestManager.HKMAEopJson.result?.records![i].krw ?? 0.0))
                dict1.append(Currency(name:"THB" , rate:RestManager.HKMAEopJson.result?.records![i].thb ?? 0.0))
                dict1.append(Currency(name:"MYR" , rate:RestManager.HKMAEopJson.result?.records![i].myr ?? 0.0))
                dict1.append(Currency(name:"EUR" , rate:RestManager.HKMAEopJson.result?.records![i].eur ?? 0.0))
                dict1.append(Currency(name:"PHP" , rate:RestManager.HKMAEopJson.result?.records![i].php ?? 0.0))
                dict1.append(Currency(name:"INR" , rate:RestManager.HKMAEopJson.result?.records![i].inr ?? 0.0))
                dict1.append(Currency(name:"HKD" , rate:1))
                temp.eoprate.append(Date(date:RestManager.HKMAEopJson.result?.records![i].end_of_month ?? "" , currency: dict1))
            }
        }
        
    }
    
    
    // UI
    
    
    
    @IBOutlet weak var currecylabel: UILabel!
    @IBOutlet weak var currencypicker: UIButton!
    @IBOutlet weak var ratetable: UITableView!
    @IBOutlet weak var eopbutton: UIButton!
    @IBOutlet weak var monthbutton: UIButton!
    @IBOutlet weak var daybutton: UIButton!
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        //rootRouter?.showTest()
        //   print(temp.dailyrate[0].dailyrate.count)
        switch sender.tag {
        case 1:
            //temp = UserProfileCache.get("rate")
            //print(RestManager.HKMARateJson.result?.datasize as! Int)
            
            tableData = temp.dailyrate
             print("dAY:  \(tableData.count)")
            print(tableData.count)
            selectedTap = 1
            ratetable.reloadData()
            
            daybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            monthbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            eopbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            daybutton.backgroundColor = UIColor.gray
            monthbutton.backgroundColor = UIColor.white
            eopbutton.backgroundColor = UIColor.white
        case 2:
            selectedTap = 2
           
            //temp = UserProfileCache.get("rate")
             
            tableData = temp.monthrate
             print("month:  \(tableData.count)")
            ratetable.reloadData()
            daybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            monthbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            eopbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            daybutton.backgroundColor = UIColor.white
            monthbutton.backgroundColor = UIColor.gray
            eopbutton.backgroundColor = UIColor.white
        case 3:
            //temp = UserProfileCache.get("rate")
            tableData = temp.eoprate
             print("eop:  \(tableData.count)")
            selectedTap = 3
            ratetable.reloadData()
            daybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            monthbutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            eopbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            daybutton.backgroundColor = UIColor.white
            monthbutton.backgroundColor = UIColor.white
            eopbutton.backgroundColor = UIColor.gray
        default:
            ratetable.reloadData()
            
        }
        
    }
    
    
}

// Make your own VC inherit the BaseViewController
//if you need to use the tab view connect to the tabBar inside the baseViewController.swift
//if you dont need the tabBar just let it be, then it will disapear
