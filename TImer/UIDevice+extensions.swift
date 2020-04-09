//
//  UIDevice+extensions.swift
//  TImer
//
//  Created by Julian Panucci on 4/9/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
