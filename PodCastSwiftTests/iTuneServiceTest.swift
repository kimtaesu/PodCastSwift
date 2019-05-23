//
//  iTuneServiceTest.swift
//  PodCastSwiftTests
//
//  Created by tskim on 21/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Moya
import RxBlocking
@testable import PodCastSwift
class iTuneServiceTest: QuickSpec {
    override func spec() {
        var service: iTuneServiceType!
        var provider: MoyaProvider<PodCastApi>!
        
        describe("An iTuneServiceTest") {
            context("success data") {
                beforeEach {
                    provider = MockPodCastProvider.sample()
                    service = iTuneService(provider)
                }
                it("podcasts isn't empty") {
                    let podcasts = try! service.searchPodcasts(keyword: "").toBlocking().single()
                    expect(podcasts.isNotEmpty) == true
                }
            }
            context("error 401") {
                beforeEach {
                    provider = MockPodCastProvider.error401()
                    service = iTuneService(provider)
                }
                it("podcasts is empty") {
                    let podcasts = try! service.searchPodcasts(keyword: "")
                        .catchErrorJustReturn([])
                        .toBlocking()
                        .single()
                    expect(podcasts.isEmpty) == true
                }
            }
        }
    }
}

