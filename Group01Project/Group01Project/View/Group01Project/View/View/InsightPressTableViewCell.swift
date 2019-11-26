//
//  InsightPressTableViewCell.swift
//  Group01Project
//
//  Created by Au Yeung Tsz Wang on 26/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

class InsightPressTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftIndicator: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func uiBind(insight: Insight){
        leftIndicator.backgroundColor = UIColor.init(red: 74, green: 144, blue: 226)
        titleLabel.text = insight.title
        dateLabel.text = "Date: \(insight.date ?? "error")"
    }
    
    
    func uiBind(press: Press){
        leftIndicator.backgroundColor = UIColor.init(red: 233, green: 114, blue: 21)
        titleLabel.text = press.title
        dateLabel.text = "Date: \(press.date ?? "error")"
    }
    
}
