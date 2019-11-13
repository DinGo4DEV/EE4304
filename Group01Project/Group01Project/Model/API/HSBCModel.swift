//
//  HSBCModel.swift
//  Group01Project
//
//  Created by Stanley on 12/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import Foundation
struct HSBC{
    enum URL:String{
        case FxChangeURL="https://rbwm-api.hsbc.com.hk/digital-pws-tools-investments-eapi-prod-proxy/v1/investments/exchange-rate?locale=en_HK"
    }
    
    
    struct FxRateJson:Codable{
        var detailRates: [detailRates]?
    }
    
    struct detailRates:Codable{
        var ccy: String
        var ccyName: String
        var lastUpdateDate: String
        var ttBuyRt: String             //Telegraphic Transfer
        var ttSelRt: String
        var bankBuyRt: String
        var bankSellRt: String
    }
}
