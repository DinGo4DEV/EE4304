//
//  store.swift
//  Group01Project
//
//  Created by Stanley on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

//"candidates" : [
//   {
//      "formatted_address" : "Lower Ground Floor, The Westwood of The Belcher's, 8 Belcher's Street Sai wan, Shek Tong Tsui, Hong Kong",
//      "geometry" : {
//         "location" : {
//            "lat" : 22.2856599,
//            "lng" : 114.1329968
//         },
//         "viewport" : {
//            "northeast" : {
//               "lat" : 22.28700757989272,
//               "lng" : 114.1342769798927
//            },
//            "southwest" : {
//               "lat" : 22.28430792010727,
//               "lng" : 114.1315773201073
//            }
//         }
//      },
//      "name" : "花旗銀行(香港) – 自動櫃員機/ Citibank Hong Kong – ATM",
//      "opening_hours" : {
//         "open_now" : true
//      },
//      "place_id" : "ChIJLVd0uYT_AzQR3SsngPr7y4w",
//      "types" : [ "atm", "finance", "point_of_interest", "establishment" ]
//   }
//]

class store: Object, Mappable{
    var candidates = List<candidates>()
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        
        candidates <- map["candidates"]
        
    }
}

class candidates: Object, Mappable{
    @objc dynamic var formatted_address : String?
    
    var geometry = List<geometry>()
    @objc dynamic var name: String?
    @objc dynamic var place_id: String?
    var types = List<types>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        geometry <- map["geometry"]
        name <- map["name"]
        place_id <- map["place_id"]
        types <- map["types"]
        
    }
    
}

class geometry: Object, Mappable{
    var location = List<location>()
    var viewport = List<viewport>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        viewport <- map["viewport"]
    }
}

class location:Object,Mappable{
    @objc dynamic var lat : String?
    @objc dynamic var lng : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class viewport:Object, Mappable{
    var northeast = List<northeast>()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        northeast <- map["northeast"]
    }
}

class northeast:Object, Mappable{
    @objc dynamic var lat : String?
    @objc dynamic var lng : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class southwest:Object,Mappable{
    @objc dynamic var lat : String?
    @objc dynamic var lng : String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class types:Object,Mappable{
    @objc dynamic var atm : String?
    @objc dynamic var finance : String?
    @objc dynamic var point_of_interest : String?
    @objc dynamic var establishment : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        atm <- map["atm"]
        finance <- map["finance"]
        point_of_interest <- map["point_of_interest"]
        establishment <- map["establishment"]
    }
}


