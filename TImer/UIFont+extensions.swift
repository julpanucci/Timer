//
//  UIFont+extensions.swift
//  TImer
//
//  Created by Julian Panucci on 4/9/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit

extension UIFont {
    
    public enum `Type`: String {
        case semibold = "-SemiBold"
        case regular = "-Regular"
        case light = "-Light"
        case extraBold = "-ExtraBold"
        case bold = "-Bold"
    }
    
    public enum CustomFont: String {
        case orbitron = "Orbitron"
    }
    
    static func customFont(_ font: CustomFont, type: Type? = nil, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        var mFont = ""
        if let type = type {
            mFont = "\(font.rawValue)\(type.rawValue)"
        }
        if let font = UIFont(name: mFont, size: size) {
            return font
        } else {
            print("\nCould not find font. Make sure it is added to your Info.plist!\n")
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}
