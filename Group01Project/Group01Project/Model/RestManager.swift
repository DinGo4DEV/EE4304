//
//  RestManager.swift
//  Group01Project
//
//  Created by Stanley on 11/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
class RestManager{
    var requestHttpHeader = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    var responseHandler: ((Any)->Void)?
    
    static var HengSengRateJson:HengSeng.FxRateJson!
    static var HSBCRateJson:HSBC.FxRateJson!
    static var HKMARateJson:HKMA.FxRateJson!
    static var HengSengBranchJson:HengSeng.branchJson!
    
    init() {
        requestHttpHeader.add(value: "application/json", forKey: "content-type")
    }
    
    func request_fxttChange_HengSeng(handler:@escaping ((Codable) -> Void)){
        let url = URL(string: HengSeng.URL.TtFxChangeURL.rawValue)!
        request(url: url, model: HengSeng.FxRateJson.self){
            [weak self](result) in
            handler(result)
        }
    }
    
    func request_fxnoteExchangeRates_HengSeng(handler:@escaping ((Codable) -> Void)){
        let url = URL(string: HengSeng.URL.NoteFxChangeURL.rawValue)!
        request(url: url, model: HengSeng.FxRateJson.self){
            [weak self](result) in
            handler(result)
        }
    }
    
    func request_Branch_HengSeng(handler:@escaping ((Codable) -> Void)){
        let url = URL(string: HengSeng.URL.BranchURL.rawValue)!
        request(url: url, model: HengSeng.branchJson.self){
            [weak self](result) in
            handler(result)
        }
    }
    
    func request_fxChange_HKMA(params:HKMA.params, handler:@escaping((Codable) -> Void)){
        let baseURL:String = HKMA.URL.FxChangeURL.rawValue
        let fullURL:String = "\(baseURL)?\(params.offset)&\(params.form)&\(params.to)&\(params.sortOrder)"
        //        let url = URL(string: fullURL)
        let url = URL(string: baseURL)!
        request(url: url, model: HKMA.FxRateJson.self){
            [weak self](result) in
            handler(result)
        }
    }
    
    func request<T:Codable>(url:URL, model:T.Type, completion: @escaping ((Codable) -> Void)){
        let task = URLSession.shared.dataTask(with: url){
            (data,response,error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(model,from:data){
                completion(result)
                
            } else {
                print("error")
            }
        }
        
        task.resume()
    }
}

extension RestManager{
    
    enum HttpMethod: String{
        case get
        case post
        case put
        case patch
        case delete
    }
    
    struct RestEntity{
        private var values: [String:String] = [:]
        
        mutating func add(value: String, forKey key:String){
            values[key] = value
        }
        
        func value(forKey key: String)->String?{
            return values[key]
        }
        
        func allValues()->[String:String]{
            return values
        }
        
        func totalItems()->Int{
            return values.count
        }
    }
}
