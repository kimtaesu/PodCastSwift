//
//  StreamReactorTest.swift
//  PodCastSwiftTests
//
//  Created by tskim on 25/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxSwift
import RxExpect
import RxTest
import Nimble
import Quick
import AVFoundation
import FeedKit
@testable import PodCastSwift
class StreamReactorTest: QuickSpec {
    override func spec() {
        var reactor: StreamReactor!

        describe("A StreamReactor") {
            context("duration") {
                beforeEach {
                    reactor = StreamReactor(EpisodeItem(episode: EpisodeFixture.duration(100)))
                }
                it("forward") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)

                    rxRxpect.input(reactor.action, [
                        // advance time to 10
                        next(0, .changeSeekValue(0.1)),
                        next(100, .forward),
                        // advance time to 100
                        next(200, .changeSeekValue(1)),
                        next(300, .forward),
                        ])

                    rxRxpect.assert(reactor.state.map { $0.currentTime }) { events in
                        let actual100ms = events.filter {
                            $0.time == 100
                        }
                        let cmtime = actual100ms.last?.value.element
                        // 10 + 10 = 10
                        XCTAssertEqual(Int(CMTimeGetSeconds(cmtime!)), 20)
                    }
                    // assert limit max 100
                    rxRxpect.assert(reactor.state.map { $0.currentTime }) { events in
                        let actual100ms = events.filter {
                            $0.time == 300
                        }
                        let cmtime = actual100ms.last?.value.element
                        XCTAssertEqual(Int(CMTimeGetSeconds(cmtime!)), 100)
                    }
                }
                it("backward") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)
                    
                    rxRxpect.input(reactor.action, [
                        // advance time to 20
                        next(0, .changeSeekValue(0.2)),
                        next(100, .backward),
                        // advance time to 0
                        next(200, .changeSeekValue(0)),
                        next(300, .backward),
                        ])
                    
                    rxRxpect.assert(reactor.state.map { $0.currentTime }) { events in
                        let actual100ms = events.filter {
                            $0.time == 100
                        }
                        let cmtime = actual100ms.last?.value.element
                        // 20 - 10 = 10
                        XCTAssertEqual(Int(CMTimeGetSeconds(cmtime!)), 10)
                    }
                    // assert limit min 0
                    rxRxpect.assert(reactor.state.map { $0.currentTime }) { events in
                        let actual100ms = events.filter {
                            $0.time == 300
                        }
                        let cmtime = actual100ms.last?.value.element
                        XCTAssertEqual(Int(CMTimeGetSeconds(cmtime!)), 0)
                    }
                }
            }
        }
    }
}


