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


class result:Object, Mappable{
    @objc dynamic var datasize : Int = 0
//    var records = List<Insight>()
    var records:[Insight] = []
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        datasize <- map["datasize"]
        records <- map["records"]
       var records: [Insight]?
    
        if let records = records {
            for record in records {
                self.records.append(record)
            }
        }
    }
}

class header:Object, Mappable{
     var success: Bool?
    @objc dynamic var err_code: String?
    @objc dynamic var err_msg: String?
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        err_code <- map["err_code"]
        err_msg <- map["err_msg"]
        

    }
}
class InsightResponse: Object, Mappable {
    
    var header: header?
    var result: result?
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        header <- map["header"]
        result <- map["result"]
//        var resultList: [result]?
//        if let result = resultList {
//             for result in resultList {
//               self.result.append(result)
//             }
//        }

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
