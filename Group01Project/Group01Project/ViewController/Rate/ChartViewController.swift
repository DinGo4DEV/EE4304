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
    
    @IBOutlet var CharView: LineChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    public class LineChartFormatter: NSObject, IAxisValueFormatter
    {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String
        {
            return months[Int(value)]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [7.85, 7.84, 7.83, 7.82, 7.81, 7.8]
        
        setChart(dataPoints: months, values: unitsSold)
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
        
        var colors: [UIColor] = []
        //let values =  (0... < 20 ).map { (i) -> ChartDataEntry in
        //  let val = Double
        //}
        let formato:LineChartFormatter = LineChartFormatter()
        let xaxis:XAxis = XAxis()
        var dataEntries = [ChartDataEntry]()
        var j : Double = 0.0
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry(x: j, y: values[i], data: dataPoints[i])
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
            
            j = j + 1.0
        }
        xaxis.valueFormatter = formato
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        let line1 = LineChartDataSet(entries: dataEntries, label: "Numbers")
        let data = LineChartData()
        data.addDataSet(line1)
        CharView.data = data
        CharView.xAxis.valueFormatter = xaxis.valueFormatter
        
    }
    
    
}

