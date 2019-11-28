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


class GMarker:NSObject{
    var name:String
    var icon:String?
    var location:latlng?
    var type:[String]?
    
    init(name:String, icon:String?, location:latlng?, type:[String]?) {
             self.name = name
             self.icon = icon ?? ""
            self.location = location
            self.type = type ?? [""]
         }

         override var hash: Int {
         return location.hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? GMarker else {
            return false
        }
        let lhs = self

        return lhs.location == rhs.location
    }
         
}

class Geometry: Object, Mappable{
    var location:latlng?
    var viewport:[Viewport] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        viewport <- map["viewport"]
        var viewport:[Viewport]?
        if let viewport = viewport {
            for v in viewport{
                self.viewport.append(v)
            }
        }
    }
}

class Viewport:Object, Mappable{
    var northeast: latlng?
    var southwest: latlng?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        northeast <- map["northeast"]
        southwest <- map["southwest"]
    }
}

class latlng:Object,Mappable{
    var lat:Double?
    var lng:Double?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
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

class Types:Object,Mappable{
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

class OpenNow:Object,Mappable{
    var open_now:Bool?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        open_now <- map["open_now"]
    }
}

class Photo:Object,Mappable{
    var height:Int?
    var html_attributions:[String] = []
    var photo_reference:String?
    var width:Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        height <- map["height"]
        html_attributions <- map["html_attributions"]
        var html_attributions:[String]?
        if let html_attributions = html_attributions{
            for a in html_attributions{
                self.html_attributions.append(a)
            }
        }
        photo_reference <- map["photo_reference"]
        width <- map["width"]
    }
}

class PlusCode:Object,Mappable{
    var compound_code:String?
    var global_code:String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        compound_code <- map["compound_code"]
        global_code <- map["global_code"]
    }
}

class StoreResponse:Object, Mappable{
    var html_attributions: AnyObject?
    var next_page_token: String?
    var results:[Store]=[]
    var status:String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        next_page_token <- map["next_page_token"]
        results <- map["results"]
        var results:[Store]?
        if let results = results{
            for result in results{
                self.results.append(result)
            }
        }
        status <- map["status"]
    }
}

class Store:Object,Mappable{
    var geometry: Geometry?
    var icon: String?
    var id: String?
    var name:String?
    var opening_hours:[OpenNow]=[]
    var photos:[Photo]=[]
    var place_id:String?
    var plus_code:[PlusCode] = []
    var rating: Float?
    var reference:String?
    var scope:String?
    var types:[String] = []
    var user_ratings_total:Int?
    var vicinity:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        geometry <- map["geometry"]
        icon <- map["icon"]
        id <- map["id"]
        name <- map["name"]
        opening_hours <- map["opening_hours"]
        photos <- map["photos"]
        place_id <- map["place_id"]
        plus_code <- map["plus_code"]
        rating <- map["rating"]
        reference <- map["reference"]
        scope <- map["scope"]
        types <- map["types"]
        user_ratings_total <- map["user_ratings_total"]
        vicinity <- map["vicinity"]
        
        var types:[String]?
        if let types = types{
            for type in types{
                self.types.append(type)
            }
        }
    }
    
    
}


