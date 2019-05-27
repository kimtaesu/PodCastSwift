//
//  EdpisodeFixture.swift
//  PodCastSwiftTests
//
//  Created by tskim on 25/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import FeedKit
@testable import PodCastSwift

class EpisodeFixture {
    static func duration(_ duration: Int) -> Episode {
        return Episode(episode: 0, title: "", pubDate: Date(), description: "", author: "", imageUrl: "", streamUrl: "", duration: 100, size: 0)
    }
    static var sample: [Episode] {
        let data = ResourcesLoader.readData("sample_episode", type: "rss")
        return FeedParser(data: data).parse().rssFeed!.items!.compactMap { feed in
            Episode(feedItem: feed)
            }
    }
}
