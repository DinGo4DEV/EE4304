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
        case FxChangeURL = "https://rbwm-api.hsbc.com.hk/pws-hk-hase-rates-papi-prod-proxy/v1/fxtt-exchange-rates"
    }
    
    struct FxRate_HengSeng:Codable{
        var lastUpdateTime: String
        var fxttExchangeRates:[fxttExchangeRates]?
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
    
    enum FxRate_HengSengKeys: String, CodingKey{
        case lastUpdateTime,fxttExchangeRates
    }
    
    enum fxttExchangeRatesKeys: String, CodingKey{
        case ccyCode, ccyDisplayCode, ccyDisplayName,ccyBaseRemark, chartFlag, ttBuyRate, ttSellRate, ccyNameZh, ccyNameCn,ccyNameEn
    }
}
