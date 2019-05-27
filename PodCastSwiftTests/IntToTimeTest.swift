//
//  IntToTimeTest.swift
//  PodCastSwiftTests
//
//  Created by tskim on 25/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Nimble
import Quick
@testable import PodCastSwift
class IntToTimeTest: QuickSpec {
    override func spec() {
        describe("An IntToTimeTest") {
            it("a value with int to time format for (hh:mm:ss)") {
                expect(100.formatTime) == "01:40"
                expect(1.formatTime) == "00:01"
                expect(9945.formatTime) == "02:45:45"
            }
        }
    }
}

