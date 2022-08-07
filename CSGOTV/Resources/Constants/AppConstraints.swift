//
//  AppConstraints.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import UIKit

struct AppConstraints {
    struct Image {
        static let xSmall: CGFloat = 16.0
        static let small: CGFloat = 60.0
        static let medium: CGFloat = 100.0
        static let big: CGFloat = 150.0
        static let landingLogoSize: CGFloat = 113.0
    }
    
    struct Animation {
        struct Duration {
            static let slow: TimeInterval = 3.0
            static let fast: TimeInterval = 0.4
        }
    }
}
