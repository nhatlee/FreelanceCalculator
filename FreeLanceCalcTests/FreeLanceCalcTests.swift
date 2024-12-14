//
//  FreeLanceCalcTests.swift
//  FreeLanceCalcTests
//
//  Created by Nhat Le on 28/9/24.
//

import Testing
@testable import FreeLanceCalc
struct FreeLanceCalcTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func floatingPointExtractInt() {
        intergerPartExpected(1.0, expect: 1)
        
    
        intergerPartExpected(8.30, expect: 8)
        
        
        intergerPartExpected(5.04, expect: 5)
        
        intergerPartExpected(5.55, expect: 5)
        
        intergerPartExpected(5.999, expect: 5)
    }
    
    func intergerPartExpected(_ num: Float, expect: Float) {
        #expect(num.whole == expect)
    }
    
    @Test func FloatExtractDecimal() {
        
        decimalPartExpected(1.0, expect: 0)
        decimalPartExpected(1234.567, expect: 0.567)
//        decimalPartExpected(8.30, expect: 0.3)
//        let f2: Float = 8.30
//        #expect(f2.fraction == 0.3)
//
//        
//        decimalPartExpected(5.04, expect: 0.04)
//        
//        
//        decimalPartExpected(5.55, expect: 0.55)
//        
//        
//        decimalPartExpected(5.999, expect: 0.999)
    }
    
    func decimalPartExpected(_ num: Float, expect: Float) {
        #expect(num.fraction == expect)
    }

}
