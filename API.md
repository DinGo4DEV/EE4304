# HKMA ![Image of HKMA](https://www.hkma.gov.hk/statics/assets/img/logo.jpg)
1. [Exchange Rate - Daily figures](https://apidocs.hkma.gov.hk/chi/documentation/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-daily)
    > https://api.hkma.gov.hk/public/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-daily
    
    |  |Offset | Form | To | Sory By | Sort Order |
    |-- |-------  | ------- | ------- | ------- | ------- |
    |TYPE | Int | Sring | String | Sting | String|
    |E.g. | 10 (show 10 records) |"YYYY-MM-DD"|"YYYY-MM-DD"|| "Desc"/"Asc"|
    
```json
"Record": {
 "title": "Record",
 "type": "object",
 "properties": {
   "end_of_day": {
      "type": "string",
      "format": "date"
   },
   "usd": {"type": "number"},
   "gbp": {"type": "number"},
   "jpy": {"type": "number"},
   "cad": {"type": "number"},
   "aud": {"type": "number"}, 
   "sgd": {"type": "number"},
   "twd": {"type": "number"},
   "chf": {"type": "number"},
   "cny": {"type": "number"},
   "krw": {"type": "number"},
   "thb": {"type": "number"},
   "myr": {"type": "number"},
   "dem": {"type": "number"},
   "nlg": {"type": "number"},
   "bef": {"type": "number"},
   "frf": {"type": "number"},
   "itl": {"type": "number"},
   "eur": {"type": "number"},
   "php": {"type": "number"},
   "inr": {"type": "number"},
   "special_drawing_rights": {"type": "number"},
   "neeri_1983_trade_wgt": {"type": "number"}, "neeri_1983_import_wgt": {"type": "number"}, "neeri_1983_export_wgt": {"type": "number"},
   "neeri_2000_trade_wgt": {"type": "number"}, "neeri_2000_import_wgt": {"type": "number"},"neeri_2000_export_wgt": {"type": "number"},
    "neeri_2010_trade_wgt": {"type": "number"}, "neeri_2010_import_wgt": {"type": "number"},"neeri_2010_export_wgt": {"type": "number"}
    }
}
```
  ---
2. [Exchange Rate - Period average figures](https://apidocs.hkma.gov.hk/documentation/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-periodaverage/)
    > https://api.hkma.gov.hk/public/market-data-and-statistics/monthly-statistical-bulletin/er-ir/er-eeri-periodaverage
    
    |  |Offset | Form | To | Sory By | Sort Order |
    |-- |-------  | ------- | ------- | ------- | ------- |
    |TYPE | Int | Sring | String | Sting | String|
    |E.g. | 10 (show 10 records) |"YYYY-MM"|"YYYY-MM"|| "Desc"/"Asc"|

   ** Record Same with 1.[Exchange Rate - Daily figures] **
   
   # HSBC ![Image of HSBC](https://scontent-hkg3-1.xx.fbcdn.net/v/t1.0-1/p50x50/19598631_1410961878970160_6055011217242112608_n.png?_nc_cat=1&_nc_oc=AQmjT0lpFY2015YB-F6tmHq-EVwj0HMVWYhLf0LvZ_PAM7Ucm4EGv6uDic1sLkhAFNM&_nc_ht=scontent-hkg3-1.xx&oh=c5a38d5125c2c22ce2622cfebcb77137&oe=5E50B817) / HangSeng ![Image of HangSeng](https://www.hangseng.com/etc/designs/hase/clientlib-common/images/logo.gif) 
  1. FX change API:
   > https://rbwm-api.hsbc.com.hk/pws-hk-hase-rates-papi-prod-proxy/v1/fxtt-exchange-rates
   
   | | ccyCode | ccyDisplayCode | ccyDisplayName | ccyBaseRemark | chartFlag | ttBuyRate | ttySellRate | ccyNameZh | ccyNameCn | ccyNameEn |
   |-| ------- | -------------| ----------- | --------- | ------ | ------ | ------ | ----- | -------| ------ |
   |TYPE| String | String | String | String | String | String | String | String | String | String |
   |E.g.| USS | USD | US Dollar | | Y | 7.8110 | 7.8410 | 美元 | 美元 | US Dollar |
   ```
   {
    "lastUpdateTime": "2019-11-08T11:26:00+08:00",
    "fxttExchangeRates": [
        {
            "ccyCode": "USS",
            "ccyDisplayCode": "USD",
            "ccyDisplayName": "US Dollar",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "7.8110",
            "ttSellRate": "7.8410",
            "ccyNameZh": "美元",
            "ccyNameCn": "美元",
            "ccyNameEn": "US Dollar"
        },
        {
            "ccyCode": "CNY",
            "ccyDisplayCode": "CNY",
            "ccyDisplayName": "Renminbi",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "1.1151",
            "ttSellRate": "1.1282",
            "ccyNameZh": "人民幣",
            "ccyNameCn": "人民币",
            "ccyNameEn": "Renminbi"
        },
        {
            "ccyCode": "CNH",
            "ccyDisplayCode": "CNH",
            "ccyDisplayName": "Renminbi",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "1.1151",
            "ttSellRate": "1.1282",
            "ccyNameZh": "人民幣",
            "ccyNameCn": "人民币",
            "ccyNameEn": "Renminbi"
        },
        {
            "ccyCode": "AUD",
            "ccyDisplayCode": "AUD",
            "ccyDisplayName": "Australian Dollar",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "5.3470",
            "ttSellRate": "5.4190",
            "ccyNameZh": "澳元",
            "ccyNameCn": "澳元",
            "ccyNameEn": "Australian Dollar"
        },
        {
            "ccyCode": "CAD",
            "ccyDisplayCode": "CAD",
            "ccyDisplayName": "Canadian Dollar",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "5.9000",
            "ttSellRate": "5.9700",
            "ccyNameZh": "加元",
            "ccyNameCn": "加元",
            "ccyNameEn": "Canadian Dollar"
        },
        {
            "ccyCode": "CHF",
            "ccyDisplayCode": "CHF",
            "ccyDisplayName": "Swiss Franc",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "7.8210",
            "ttSellRate": "7.9180",
            "ccyNameZh": "瑞士法郎",
            "ccyNameCn": "瑞士法郎",
            "ccyNameEn": "Swiss Franc"
        },
        {
            "ccyCode": "EUR",
            "ccyDisplayCode": "EUR",
            "ccyDisplayName": "Euro",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "8.6010",
            "ttSellRate": "8.7010",
            "ccyNameZh": "歐羅",
            "ccyNameCn": "欧罗",
            "ccyNameEn": "Euro"
        },
        {
            "ccyCode": "GBP",
            "ccyDisplayCode": "GBP",
            "ccyDisplayName": "Pound Sterling",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "9.9690",
            "ttSellRate": "10.0850",
            "ccyNameZh": "英鎊",
            "ccyNameCn": "英镑",
            "ccyNameEn": "Pound Sterling"
        },
        {
            "ccyCode": "JPY",
            "ccyDisplayCode": "JPY",
            "ccyDisplayName": "Japanese Yen",
            "ccyBaseRemark": "(per 1,000)",
            "chartFlag": "Y",
            "ttBuyRate": "71.1600",
            "ttSellRate": "72.0800",
            "ccyNameZh": "日圓",
            "ccyNameCn": "日圆",
            "ccyNameEn": "Japanese Yen"
        },
        {
            "ccyCode": "NZD",
            "ccyDisplayCode": "NZD",
            "ccyDisplayName": "New Zealand Dollar",
            "ccyBaseRemark": "",
            "chartFlag": "Y",
            "ttBuyRate": "4.9420",
            "ttSellRate": "5.0220",
            "ccyNameZh": "紐西蘭元",
            "ccyNameCn": "纽西兰元",
            "ccyNameEn": "New Zealand Dollar"
        },
        {
            "ccyCode": "SGD",
            "ccyDisplayCode": "SGD",
            "ccyDisplayName": "Singapore Dollar",
            "ccyBaseRemark": "",
            "chartFlag": "",
            "ttBuyRate": "5.7410",
            "ttSellRate": "5.7800",
            "ccyNameZh": "新加坡元",
            "ccyNameCn": "新加坡元",
            "ccyNameEn": "Singapore Dollar"
        },
        {
            "ccyCode": "THB",
            "ccyDisplayCode": "THB",
            "ccyDisplayName": "Thai Baht",
            "ccyBaseRemark": "",
            "chartFlag": "",
            "ttBuyRate": "0.2503",
            "ttSellRate": "0.2672",
            "ccyNameZh": "泰銖",
            "ccyNameCn": "泰铢",
            "ccyNameEn": "Thai Baht"
        },
        {
            "ccyCode": "ZAR",
            "ccyDisplayCode": "ZAR",
            "ccyDisplayName": "South African Rand",
            "ccyBaseRemark": "",
            "chartFlag": "",
            "ttBuyRate": "0.5150",
            "ttSellRate": "0.5460",
            "ccyNameZh": "南非蘭特",
            "ccyNameCn": "南非兰特",
            "ccyNameEn": "South African Rand"
        }
    ]
}
```

---

2.[Branch](https://www.hangseng.com/en-hk/contact-us/branch-addresses.data.getjson.js)
> https://www.hangseng.com/en-hk/contact-us/branch-addresses.data.getjson.js


   ## Userful Link
   https://sandboxportal.apix.com.hk/jetco/sb/categories
