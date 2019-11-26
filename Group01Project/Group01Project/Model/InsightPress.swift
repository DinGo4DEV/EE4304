//
//  Insight.swift
//  Group01Project
//
//  Created by Zensis on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Insight: Object, Mappable{
    @objc dynamic var date: String?
    @objc dynamic var title : String?
    @objc dynamic var link : String?
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        
        date <- map["date"]
        title <- map["title"]
        link <- map["link"]
        
    }
}

class Press: Object, Mappable{
    @objc dynamic var date: String?
    @objc dynamic var title : String?
    @objc dynamic var link : String?
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        
        date <- map["date"]
        title <- map["title"]
        link <- map["link"]
        
    }
}

class InsightResponse:  Object, Mappable {
    var datasize : Int = 0
    var records = List<Insight>()
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        datasize <- map["datasize"]
        
       var records: [Insight]?
    records <- map["records"]
        if let records = records {
            for record in records {
                self.records.append(record)
            }
        }
    }
}

class PressResponse: Object, Mappable {
    var datasize : Int?
    var records = List<Press>()
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        datasize <- map["datasize"]
        
           var records: [Press]?
        records <- map["records"]
            if let records = records {
                for record in records {
                    self.records.append(record)
                }
            }
        }
}
