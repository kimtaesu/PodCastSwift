//
//  MockPodcastServiceType.swift
//  PodCastSwiftTests
//
//  Created by tskim on 26/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
@testable import PodCastSwift

class MockPodcastServiceType: PodcastServiceType {
    
    let result: Result<[Episode], Error>
    
    init(_ result: Result<[Episode], Error>) {
        self.result = result
    }
    func parseEpisodes(url: String?) throws -> Observable<[Episode]> {
        return Observable.just(try result.get())
    }
}
