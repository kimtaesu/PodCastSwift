//
//  PodcastFixture.swift
//  PodCastSwiftTests
//
//  Created by tskim on 26/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import PodCastSwift

class PodcastFixture {
    static let podcastReposnse: MediumResponse = ResourcesLoader.loadJson("sample_podcast")
    
    static var sample: [Podcast] {
        return podcastReposnse.results
    }
    static var random: Podcast {
        return podcastReposnse.results.randomElement()!
    }
}
