//
//  UIColor+UserInterfaceStyle.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/26.
//

import UIKit

extension UIColor {
    static var userInterfaceStyleBackgroundColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            return UIColor.systemGray
        }
        return UIColor.systemBackground
    }
    
    static var userInterfaceStyleShadowColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            return UIColor.white
        }
        return UIColor.black
    }
}
