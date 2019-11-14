//
//  HengSengModel.swift
//  Group01Project
//
//  Created by Stanley on 11/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation

struct HengSeng{
    
    enum URL:String {
        case TtFxChangeURL = "https://rbwm-api.hsbc.com.hk/pws-hk-hase-rates-papi-prod-proxy/v1/fxtt-exchange-rates"
        case NoteFxChangeURL = "https://rbwm-api.hsbc.com.hk/pws-hk-hase-rates-papi-prod-proxy/v1/fxnotes-exchange-rates"
        case BranchURL = "https://www.hangseng.com/en-hk/contact-us/branch-addresses.data.getjson.js"
    }
    
    struct FxRateJson:Codable{
        var lastUpdateTime: String
        var fxttExchangeRates:[fxttExchangeRates]?
        var fxnoteExchangeRates:[fxnoteExchangeRates]?
    }
    
    struct fxnoteExchangeRates:Codable{
        var ccyCode: String
        var ccyDisplayCode: String
        var ccyDisplayName: String
        var noteBuyRate: String
        var noteSellRate: String
    }
    
    struct fxttExchangeRates:Codable{
        var ccyCode: String
        var ccyDisplayCode: String
        var ccyDisplayName: String
        var ccyBaseRemark: String
        var chartFlag: String
        var ttBuyRate: String
        var ttSellRate: String
        var ccyNameZh: String
        var ccyNameCn: String
        var ccyNameEn: String
    }
    
    struct  branchJson:Codable {
//        var DistrictGroup: [districtGroup]?
//        var ServiceType: [serviceType]?
//        var SpecificService:[specificService]?
        var Branch:[branch]?
    }
    
    struct branch:Codable{
        var Code: String
        var Name: String
        var NameEn: String
        var SubDistrict: String
        var Address: String
        var Outlet: String
        var Disable: Bool
        var SEC: Bool
        var SDB: Bool
        var ATM: Bool
        var ATMRMB: Bool
        var ATMFCM: Bool
        var CDM: Bool
        var CHQ: Bool
        var CHQCUT: String
        var ACOP: Bool
        var CS: Bool
        var WM: Bool
        var HourWeekdays: String
        var HourSat: String
        var HourSun: String
        var HourRemark: String
        var HourAMB: String
        var Lat: String
        var Lng: String
    }
    
    struct districtGroup:Codable{

        var DisGroupCode: String
        var DisGroupName: String
        var DisGroupNameEn: String?
        var District:[district]?
    }
    
    struct district:Codable{
        var Code: String
        var Name: String
        var NameEn: String?
        var hasSite: Bool?
        var SubDistricts: [subDistricts]?
    }
    
    struct subDistricts:Codable {
        var Code: String
        var Name: String
        var NameEn: String?
        var hasSite: Bool?
    }
    
    struct specificService:Codable{
        var ServiceCode: String
        var ServiceSymbol: String?
        var ServiceName: String
        var ServiceRemark: String?
        var Show: String?
    }
    
    struct serviceType:Codable{
        var ServiceCode: String
        var ServiceName: String
        var ServiceNameEn: String?
        var Show: String?
    }
    
    
    
    enum FxRateJsonKeys: String, CodingKey{
        case lastUpdateTime,fxttExchangeRates
    }
    
    enum fxttExchangeRatesKeys: String, CodingKey{
        case ccyCode, ccyDisplayCode, ccyDisplayName,ccyBaseRemark, chartFlag, ttBuyRate, ttSellRate, ccyNameZh, ccyNameCn,ccyNameEn
    }
    
    
}
