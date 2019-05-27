//
//  PodcastListReactorTest.swift
//  PodCastSwiftTests
//
//  Created by tskim on 26/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxSwift
import RxExpect
import RxTest
import Nimble
import Quick
import Cuckoo
@testable import PodCastSwift

class PodcastListReactorTest: QuickSpec {
    override func spec() {

        let episodes = EpisodeFixture.sample
        let podcast: Podcast = PodcastFixture.random

        describe("A PodcastListReactorTest") {
            var reactor: PodcastListReactor!
            var serivce: PodcastServiceType!

            context("when given sample episodes") {
                beforeEach {
                    serivce = MockPodcastServiceType(Result.success(episodes))
                    reactor = PodcastListReactor(podcast: podcast, service: serivce)
                }
                it("action SkipNext") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)

                    rxRxpect.input(reactor.action, [
                        next(0, .parseEpidsodes),
                        next(100, .presentEpisode(1)),
                        next(200, .skipNext),
                        ])
                    rxRxpect.assert(reactor.state.map { $0.currentPlayingIndex }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(100, 1),
                            next(200, 2)
                            ])
                    }
                }
                it("action SkipNext, it reach end") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)
                    
                    let maxSize = reactor.currentState.objects.count - 1
                    rxRxpect.input(reactor.action, [
                        next(0, .parseEpidsodes),
                        next(100, .presentEpisode(maxSize)),
                        next(200, .skipNext)
                        ])
                    rxRxpect.assert(reactor.state.map { $0.currentPlayingIndex }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(100, maxSize),
                            next(200, maxSize)
                            ])
                    }
                    rxRxpect.assert(reactor.state.map { $0.message }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(200, L10n.podcastLastEpisodeMessage)
                            ])
                    }
                }
                it("action SkipPrev") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)
                    
                    rxRxpect.input(reactor.action, [
                        next(0, .parseEpidsodes),
                        next(100, .presentEpisode(5)),
                        next(200, .skipPrev),
                        ])
                    rxRxpect.assert(reactor.state.map { $0.currentPlayingIndex }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(100, 5),
                            next(200, 4)
                            ])
                    }
                }
                it("action SkipPrev, it reach zero") {
                    let rxRxpect = RxExpect()
                    rxRxpect.retain(reactor)
                    
                    let minSize = 1
                    rxRxpect.input(reactor.action, [
                        next(0, .parseEpidsodes),
                        next(100, .presentEpisode(minSize)),
                        next(200, .skipPrev)
                        ])
                    rxRxpect.assert(reactor.state.map { $0.currentPlayingIndex }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(100, minSize),
                            next(200, minSize)
                            ])
                    }
                    rxRxpect.assert(reactor.state.map { $0.message }.filterNil()) { events in
                        XCTAssertEqual(events, [
                            next(200, L10n.podcastFirstEpisodeMessage)
                            ])
                    }
                }
            }

        }
    }
}

