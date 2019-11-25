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
