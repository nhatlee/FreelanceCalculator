//
//  Double.swift
//  FreeLanceCalc
//
//  Created by Nhat Le on 28/9/24.
//

import Foundation

extension FloatingPoint {
    var whole: Self { modf(self).0 }
    
    var fraction: Self { modf(self).1 }
}


extension Decimal {
    func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var result = Decimal()
        var number = self
        NSDecimalRound(&result, &number, 0, roundingMode)
        return result
    }
    var whole: Decimal { rounded(sign == .minus ? .up : .down) }
    var fraction: Decimal { self - whole }
}
