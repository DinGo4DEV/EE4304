//
//  SyncData.swift
//  Group01Project
//
//  Created by Zensis on 25/11/2019.
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

        Alamofire.request(insightURL).responseObject { (response: DataResponse<InsightResponse>) in

            guard let insightResponse = response.result.value else{
                completed?(nil)
                return
            }
            print(response.value)
            print(insightResponse.result!.records)
            SyncData.writeRealmAsync({ (realm) in
                realm.delete(realm.objects(InsightResponse.self))
                realm.add(insightResponse)
                print(insightResponse.result!.records.first)
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
    
    
}
