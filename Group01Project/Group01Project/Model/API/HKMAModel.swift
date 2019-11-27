//
//  HKMAModel.swift
//  Group01Project
//
//  Created by Stanley on 12/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation

struct HKMA{
    
    enum URL:String {
        case FxChangeURL = "https://api.hkma.gov.hk/public/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-daily"
        case MonthURL = "https://api.hkma.gov.hk/public/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-periodaverage"
        case EopURL = "https://api.hkma.gov.hk/public/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-endperiod"
    }
    
    //Params: use += to add the value to parmas
    struct params{
        var offset:String = "offset=" // offset value > 0
        var form:String = "form="      // YYYY-MM-DD
        var to:String = "to="
        var sortOrder:String = "Sort=" //"Desc" ot "Asc"
    }
    
    struct FxRateJson:Codable{
        var header: header
        var result:fxRateResult?
    }
    
    struct MonthJson:Codable{
        var header : header
        var result : monthResult?
    }
    
    struct header:Codable{
        var success:Bool
        var err_code:String
        var err_msg:String
    }
    
    struct fxRateResult:Codable{
        var datasize: Int
        var records: [fxRecords]?
    }
    
    struct monthResult:Codable{
        var datasize:Int
        var records: [monthRecords]?
    }
    
    struct monthRecords:Codable{
        var end_of_month: String
        var usd: Double?
        var gbp: Double?
        var jpy: Double?
        var cad: Double?
        var aud: Double?
        var sgd: Double?
        var twd: Double?
        var chf: Double?
        var cny: Double?
        var krw: Double?
        var thb: Double?
        var myr: Double?
        var dem: Double?
        var nlg: Double?
        var bef: Double?
        var frf: Double?
        var itl: Double?
        var eur: Double?
        var php: Double?
        var inr: Double?
    }
    
    struct fxRecords:Codable {
        var end_of_day: String
        var usd: Double?
        var gbp: Double?
        var jpy: Double?
        var cad: Double?
        var aud: Double?
        var sgd: Double?
        var twd: Double?
        var chf: Double?
        var cny: Double?
        var krw: Double?
        var thb: Double?
        var myr: Double?
        var dem: Double?
        var nlg: Double?
        var bef: Double?
        var frf: Double?
        var itl: Double?
        var eur: Double?
        var php: Double?
        var inr: Double?
        //        var special_drawing_rights: Double?
        //        var neeri_1983_trade_wgt: Double?
        //        var neeri_1983_import_wgt: Double?
        //        var neeri_1983_export_wgt: Double?
        //        var neeri_2000_trade_wgt: Double?
        //        var neeri_2000_import_wgt: Double?
        //        var neeri_2000_export_wgt: Double?
        //        var neeri_2010_trade_wgt: Double?
        //        var neeri_2010_import_wgt: Double?
        //        var neeri_2010_export_wgt: Double?
    }
    
    enum FxRateJsonKeys: String, CodingKey{
        case header,fxRateResult
    }
    
    enum headerKeys: String, CodingKey{
        case success, err_code, err_msg
    }
    
    enum fxRateResultKeys: String,CodingKey{
        case datasize,fxRecords
    }
    enum fxRecordsKeys: String, CodingKey{
        case end_of_day, usd, gbp, jpy, cad, aud, sgd, twd, chf, cny, krw, thb, myr, dem, nlg, bef, frf, itl, eur, php, inr
    }
    
    enum eopRecordsKeys: String,CodingKey{
        case end_of_day,hkd_fer_spot, hkd_fer_1w,hkd_fer_1m,hkd_fer_3m,hkd_fer_6m,hkd_fer_9m,hkd_fer_12m
    }
}

extension Encodable{
    func hasKey(for path: String) -> Bool {
        return dictionary?[path] != nil
    }
    func value(for path: String) -> Any? {
        return dictionary?[path]
    }
    var dictionary: [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any]
    }
}
