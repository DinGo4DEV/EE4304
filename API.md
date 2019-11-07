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
