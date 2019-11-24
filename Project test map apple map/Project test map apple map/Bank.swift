//
//  Bank.swift
//  Project test map apple map
//
//  Created by Neptune Wong on 23/11/2019.
//  Copyright © 2019 Neptune Wong. All rights reserved.
//

/*import Foundation
import MapKit

class Bank: NSObject, MKAnnotation {
    let Address: String?
    let ContactInformation: String
    let OpeningHours: String
    let BranchServices: Bool
    let Branch: String
    let Brand: String
    let BranchDefinition: Array<Any>
    let BranchDefinitionMeta: Array<Any>
    let coordinate: CLLocationCoordinate2D
    
    init(Address: String, ContactInformation: String, OpeningHours: String, BranchServices : Bool, Branch: String, Brand: String, BranchDefinition: Array<Any>, BranchDefinitionMeta: Array<Any>, coordinate: CLLocationCoordinate2D) {
        self.Address = Address
        self.ContactInformation = ContactInformation
        self.OpeningHours = OpeningHours
        self.BranchServices = BranchServices
        self.Branch = Branch
        self.Brand = Brand
        self.BranchDefinition = BranchDefinition
        self.BranchDefinitionMeta = BranchDefinitionMeta
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return ContactInformation
    }
    init?(json: [Any]) {
        
        // 1
        self.Address = json["Address"] as? String ?? "No Title"
        self.ContactInformation = json[12] as! String
        self.OpeningHours = json[15] as! String
        self.BranchServices = json[12] as! Bool
        self.Branch = json[12] as! String
        self.Brand = json[12] as! String
        self.BranchDefinition = json[12] as! Array
        self.BranchDefinitionMeta = json[12] as! Array
        // 2
        if let latitude = Double(json[18] as! String),
            let longitude = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
}*/


