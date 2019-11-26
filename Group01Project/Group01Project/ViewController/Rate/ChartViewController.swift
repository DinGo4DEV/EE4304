//
//  ChartViewController.swift
//  Group01Project
//
//  Created by AnimaeTech-MacMini2018 on 26/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
import Charts
import UIKit


class ChartViewController: UIViewController {
    
    @IBOutlet weak var secondCurrency: UILabel!
    @IBOutlet weak var firstCurrency: UILabel!
    
    @IBOutlet weak var dailybutton: UIButton!
    
    @IBOutlet weak var monthlybutton: UIButton!
    @IBOutlet weak var weeklybutton: UIButton!
    
    var base : String?
    var target : String?
    var data : Rate?
    var index : Int?
 
    
    @IBOutlet weak var ChartView: LineChartView!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
//    public class LineChartFormatter: NSObject, IAxisValueFormatter
//    {
//         //let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//      
//        init(months: [String]) {
//            self.x = months
//        }
//        
//        public func stringForValue(_ value: Double, axis: AxisBase?) -> String
//        {
//            
//            return x[Int(value)]
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(false)
          print("appear")
        
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(data!.monthrate.count)
        var months = [String]()
        var unitsSold = [Double]()
        for i in 0...6 {
            unitsSold.append(data!.dailyrate[abs(i-6)].currency[index!].rate! / data!.dailyrate[i].currency[15].rate!)
            
            let index = data!.dailyrate[abs(i-6)].date.index(data!.dailyrate[abs(i-6)].date.startIndex, offsetBy: 5)
            months.append(data!.dailyrate[abs(i-6)].date.substring(from: index))
        }
        //print(months)
        setChart(dataPoints: months, values: unitsSold)
        
        firstCurrency.text = base
        secondCurrency.text = target
        dailybutton.backgroundColor = UIColor.gray
                weeklybutton.backgroundColor = UIColor.white
                monthlybutton.backgroundColor = UIColor.white
                dailybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
                weeklybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
              monthlybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
        print("data: " + String(dataPoints.count))
        var colors: [UIColor] = []
        //let values =  (0... < 20 ).map { (i) -> ChartDataEntry in
        //  let val = Double
        //}
       // let formato:LineChartFormatter = LineChartFormatter.init(months: dataPoints)
        let xaxis:XAxis = XAxis()
        var dataEntries = [ChartDataEntry]()
        var j : Double = 0.0
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry.init(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
          //  formato.stringForValue(Double(i), axis: xaxis)
            
            j = j + 1.0
        }
       // xaxis.valueFormatter = formato
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        let line1 = LineChartDataSet(entries: dataEntries, label: "Exchange Rate")
        let data = LineChartData(dataSets: [line1])
        
        
        
        ChartView.xAxis.granularity = 1
        ChartView.xAxis.axisMinimum = 0
       
        ChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
         ChartView.xAxis.labelPosition = .bottom
        ChartView.xAxis.labelCount = dataPoints.count
        ChartView.xAxis.forceLabelsEnabled = true
        ChartView.xAxis.granularityEnabled = true
        ChartView.xAxis.axisMaximum = Double(dataPoints.count - 1)
        
        
        ChartView.data = data
         
    }
    
    
    
    func plotday(){
             var months = [String]()
           var unitsSold = [Double]()
        for i in 0...6 {
            unitsSold.append(data!.dailyrate[abs(i-6)].currency[index!].rate! / data!.dailyrate[abs(i-6)].currency[15].rate!)
            
            let index = data!.dailyrate[abs(i-6)].date.index(data!.dailyrate[abs(i-6)].date.startIndex, offsetBy: 5)
            months.append(data!.dailyrate[abs(i-6)].date.substring(from: index))
        }
        setChart(dataPoints: months, values: unitsSold)
    }
    func plotweek(){
             var months = [String]()
           var unitsSold = [Double]()
        let weeknum = [8,7,6,0]
        for i in weeknum {
            print(i)
            unitsSold.append(data!.dailyrate[i].currency[index!].rate! / data!.dailyrate[i].currency[15].rate!)
            let index = data!.dailyrate[i].date.index(data!.dailyrate[i].date.startIndex, offsetBy: 5)
            months.append(data!.dailyrate[i].date.substring(from: index))
        }
        
        setChart(dataPoints: months, values: unitsSold)
        
    }
    func plotmonth() {
         var months = [String]()
        var unitsSold = [Double]()
        for i in 0...5 {
            unitsSold.append(data!.monthrate[abs(i-5)].currency[index!].rate! / data!.monthrate[abs(i-5)].currency[15].rate!)
            
            let index = data!.monthrate[abs(i-5)].date.index(data!.monthrate[abs(i-5)].date.startIndex, offsetBy: 5)
            months.append(data!.monthrate[abs(i-5)].date.substring(from: index))
        }
        setChart(dataPoints: months, values: unitsSold)
    }
    
    var tableData = [Date]()
    var selectedTap = 1
    
    
    //ui
    @IBAction func buttonClicked(_ sender: UIButton) {
        //rootRouter?.showTest()
        //   print(temp.dailyrate[0].dailyrate.count)
        switch sender.tag {
        case 1:
            print(1)
            //temp = UserProfileCache.get("rate")
            //print(RestManager.HKMARateJson.result?.datasize as! Int)
            //tableData = data!.dailyrate
            selectedTap = 1
            //ratetable.reloadData()
            plotday()
            dailybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            weeklybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            monthlybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            dailybutton.backgroundColor = UIColor.gray
            weeklybutton.backgroundColor = UIColor.white
            monthlybutton.backgroundColor = UIColor.white
        case 2:
             print(2)
            selectedTap = 2
            plotweek()
            // tableData = data!.monthrate
            //ratetable.reloadData()
            dailybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            weeklybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            monthlybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            dailybutton.backgroundColor = UIColor.white
            weeklybutton.backgroundColor = UIColor.gray
            monthlybutton.backgroundColor = UIColor.white
        case 3:
             print(3)
            //temp = UserProfileCache.get("rate")
            //tableData = data!.eoprate
            selectedTap = 3
            plotmonth()
            dailybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            weeklybutton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            monthlybutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            dailybutton.backgroundColor = UIColor.white
            weeklybutton.backgroundColor = UIColor.white
            monthlybutton.backgroundColor = UIColor.gray
        default:
            selectedTap = 1
            
        }
        
    }
    
}
