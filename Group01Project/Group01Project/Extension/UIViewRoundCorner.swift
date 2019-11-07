//
//  UIViewRoundCorner.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

extension UIView {
  func roundCorners(cornerRadius: Double) {
    self.layer.cornerRadius = CGFloat(cornerRadius)
    self.clipsToBounds = true
  }
  
}
