//
//  CurrencyModel.swift
//  Group01Project
//
//  Created by vincent on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation

class Rate : Codable  {
    
    var eoprate: [Date]
    var dailyrate: [Date]
    var monthrate: [Date]
    init(dailyrate: [Date],monthrate : [Date],eoprate:[Date]) {
        self.dailyrate = dailyrate
        self.monthrate = monthrate
        self.eoprate = eoprate
    }
}

class Date : Codable  {
     
     var date: String
     var currency: [Currency]
     
     init(date: String, currency: [Currency]) {
         self.date = date
         self.currency = currency
     }
 }

 class Currency : Codable{
     
     
     var name: String
     var rate: Double?
     
     init(name: String, rate: Double? = nil) {
         self.name = name
         self.rate = rate
     }
    
 }

// Name =
//Rate = RestManager.HKMARateJson.result?.records![0].usd

