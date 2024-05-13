//
//  rotate.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 10.05.2024.
//

import Foundation

import UIKit

func rotateImage(image: UIImage, degrees: CGFloat) -> UIImage? {
    let radians = degrees * CGFloat.pi / 180
    let newSize = CGRect(origin: .zero, size: image.size)
        .applying(CGAffineTransform(rotationAngle: radians))
        .integral.size
    
    UIGraphicsBeginImageContext(newSize)
    if let context = UIGraphicsGetCurrentContext() {
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        image.draw(in: CGRect(x: -image.size.width / 2, y: -image.size.height / 2, width: image.size.width, height: image.size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage
    }
    
    return nil
}
