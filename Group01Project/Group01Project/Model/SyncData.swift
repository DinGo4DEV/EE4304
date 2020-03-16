//
//  SyncData.swift
//  Group01Project
//
//  C/Users/neptunewong/Documents/EE4304/Project/EE4304/Group01Project/Group01Project/Modelreated by Zensis on 25/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum SyncDataFailReason: Error {
  case network
  case realmWrite
  case other
}


class SyncData {
    static var firstSync : Bool  = false
    
    static var realmBackgroundQueue = DispatchQueue(label: ".realm", qos: .background)
    
    static func writeRealmAsync(_ write: @escaping (_ realm: Realm) -> Void,
                                completed: (() -> Void)? = nil) {
      SyncData.realmBackgroundQueue.async {
        autoreleasepool {
          do {
            let realm = try Realm()
            realm.beginWrite()
            write(realm)
            try realm.commitWrite()

            if let completed = completed {
              DispatchQueue.main.async {
                let mainThreadRealm = try? Realm()
                mainThreadRealm?.refresh() // Get updateds from Background thread
                completed()
              }
            }
          } catch {
            print("writeRealmAsync Exception \(error)")
          }
        }
      }
    }
    
    func firstSync(completed: ((SyncDataFailReason?) -> Void)?) {
            let insightURL = "https://api.hkma.gov.hk/public/insight-articles?lang=en"
            let pressURL = "https://api.hkma.gov.hk/public/press-releases?lang=en"

            Alamofire.request(insightURL).responseObject(keyPath: "result"){ (response: DataResponse<InsightResponse>)  in

                guard let insightResponse = response.result.value else{
                    completed?(nil)
                    return
                }
                //print((insightResponse).records)

                SyncData.writeRealmAsync({ (realm) in
                    let record = realm.objects(InsightResponse.self)
                    realm.add(insightResponse)
    
                  },completed:{
                          completed?(nil)
                    return
                })

            }
        
        Alamofire.request(pressURL).responseObject(keyPath: "result"){ (response: DataResponse<PressResponse>)  in

                       guard let pressResponse = response.result.value else{
                           completed?(nil)
                           return
                       }
                       //print((insightResponse).records)

                       SyncData.writeRealmAsync({ (realm) in
                           let record = realm.objects(PressResponse.self)
                           realm.add(pressResponse)
           
                         },completed:{
                                 completed?(nil)
                           return
                       })

                   }
        }
    
    func syncInsight(completed: ((SyncDataFailReason?) -> Void)?) {
        let insightURL = "https://api.hkma.gov.hk/public/insight-articles?lang=en"
//        let pressURL = "https://api.hkma.gov.hk/public/press-releases?lang=en"

        Alamofire.request(insightURL).responseObject(keyPath: "result"){ (response: DataResponse<InsightResponse>)  in

            guard let insightResponse = response.result.value else{
                completed?(nil)
                return
            }
            //print((insightResponse).records)

            SyncData.writeRealmAsync({ (realm) in
                let record = realm.objects(InsightResponse.self)
                record.first?.datasize = insightResponse.datasize
                record.first?.records = insightResponse.records
                
//                realm.delete(realm.objects(InsightResponse.self))
//                realm.add(insightResponse)
//
              },completed:{
                      completed?(nil)
                return
            })

        }
    }
    
    func syncPress(completed: ((SyncDataFailReason?) -> Void)?) {
//            let insightURL = "https://api.hkma.gov.hk/public/insight-articles?lang=en"
            let pressURL = "https://api.hkma.gov.hk/public/press-releases?lang=en"

            Alamofire.request(pressURL).responseObject(keyPath: "result"){ (response: DataResponse<PressResponse>)  in

                guard let pressResponse = response.result.value else{
                    completed?(nil)
                    return
                }
                print((pressResponse).records)

                SyncData.writeRealmAsync({ (realm) in
                    
                    let record = realm.objects(PressResponse.self)
                    
                    record.first?.datasize = pressResponse.datasize
                    record.first?.records = pressResponse.records
                    
    //                realm.delete(realm.objects(InsightResponse.self))
    //                realm.add(insightResponse)
    //
                  },completed:{
                          completed?(nil)
                    return
                })

            }
        }
    
//    func syncStore(type:String, lat:Double, lng: Double, radius: Int, completed: ((SyncDataFailReason?) -> Void)?) {
    func syncStore(type:String, lat:Double, lng: Double, radius: Int, completed: ((StoreResponse)  -> Void)?) {
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=\(type)&location=\(lat),\(lng)&radius=\(radius)&key=AIzaSyDae4Sln1xBvUwOF1ChiX0zOPQAfysEBOc"

        Alamofire.request(url).responseObject{ (response: DataResponse<StoreResponse>)  in

                    guard let storeResponse = response.result.value else{
//                        completed?(nil)
                        return
                    }
            SyncData.writeRealmAsync({ (realm) in
                            
                            let record = realm.objects(StoreResponse.self)
                            
                            realm.delete(realm.objects(StoreResponse.self))
                            realm.add(storeResponse)
            
                          },completed:{
                                  completed?(nil)
                            return
                        })


                }
            }
    
    
}
