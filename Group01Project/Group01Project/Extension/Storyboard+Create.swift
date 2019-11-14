//
//  Storyboard+Create.swift
//  Group01Project
//
//  Created by Zensis on 7/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit
extension UIStoryboard {
    enum Storyboard: String {
        case main = "Main"
        case insights = "Insights"
        case calculator = "Calculator"
    }

 static func storyboard(_ storyboard: Storyboard) -> UIStoryboard {
    return UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
  }

  func instantiateViewController<T: UIViewController>(_ vcClass: T.Type) -> T? {
    let viewControllerTypeName: String = String(describing: T.self)
    guard let vc = instantiateViewController(withIdentifier: viewControllerTypeName) as? T else {
      fatalError("Could not locate viewcontroller with with identifier \(viewControllerTypeName) in storyboard.")
    }
    return vc
  }
}
