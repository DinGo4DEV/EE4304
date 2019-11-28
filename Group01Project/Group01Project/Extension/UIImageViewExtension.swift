//
//  UIImageViewExtension.swift
//  Group01Project
//
//  Created by Stanley on 28/11/2019.
//  Copyright © 2019 Stanley. All rights reserved.
//

import UIKit

extension UIImage {
  
  func RBSquareImageTo(size: CGSize) -> UIImage? {
    return self.RBSquareImage()?.RBResizeImage(targetSize: size)
  }
  
  func RBSquareImage() -> UIImage? {
    let originalWidth  = self.size.width
    let originalHeight = self.size.height
    
    var edge: CGFloat
    if originalWidth > originalHeight {
      edge = originalHeight
    } else {
      edge = originalWidth
    }
    
    let posX = (originalWidth  - edge) / 2.0
    let posY = (originalHeight - edge) / 2.0
    
    let cropSquare = CGRect.init(x: posX, y: posY, width: edge, height: edge)
    
    let imageRef = self.cgImage!.cropping(to: cropSquare);
    return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: self.imageOrientation)
  }
  
  func RBResizeImage(targetSize: CGSize) -> UIImage {
    let size = self.size
    
    let widthRatio  = targetSize.width  / self.size.width
    let heightRatio = targetSize.height / self.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize.init(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }

}
