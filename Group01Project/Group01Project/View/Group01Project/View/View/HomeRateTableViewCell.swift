//
//  HomeRateTableViewCell.swift
//  Group01Project
//
//  Created by Au Yeung Tsz Wang on 27/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class HomeRateTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var baseCountry: UIImageView!
    @IBOutlet weak var exchangeCountry: UIImageView!
    @IBOutlet weak var baseCurr: UILabel!
    @IBOutlet weak var exchangeCurr: UILabel!
    
    func uiBind(country: String){
        baseCountry.image = UIImage.init(named: "hkd")
        exchangeCountry.image = UIImage.init(named: country)
        //baseCurr.text = Currency.
//        exchangeCurr.text = RestManager.HKMARateJson.result?.records[0].usd!
    }
    
}
