//
//  Double+Rounding.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public extension Double {

    /**
     Type of rounding double value

     - Normal: From 167.567 you will get 167.6
     - Down:   From 167.567 you will get 167.5
     */
    public enum RoundingType {
        case Normal
        case Down
    }

    /**
     Rounding of double value

     - parameter persicion: important number of digits after comma
     - parameter roundType: rounding type

     - returns: rounded value
     */
    public func roundValue(withPersicion persicion: UInt,
                                         roundType: RoundingType = .Normal) -> Double {
        let divider = pow(10.0, Double(persicion))

        switch roundType {
        case .Normal:
            return round(self * divider) / divider
        case .Down:
            return Double(Int(self * divider)) / divider
        }
    }

}