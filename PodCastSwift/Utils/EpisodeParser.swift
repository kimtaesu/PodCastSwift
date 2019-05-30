//
//  EpisodeParser.swift
//  PodCastSwift
//
//  Created by tskim on 21/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import FeedKit
import Foundation

enum EpisodeParseError: Error {
    case emptyURL
    case mistypeRSS
}
class EpisodeParser {
    class func parseEpisodes(podcast: Podcast) throws -> [Episode] {
        guard let feedURL = podcast.feedUrl, let url = URL(string: feedURL) else { throw EpisodeParseError.emptyURL }
        let data = FeedParser(URL: url).parse()
        switch data {
        case .failure(let error):
            throw error
        case .atom:
            throw EpisodeParseError.mistypeRSS
        case .json:
            throw EpisodeParseError.mistypeRSS
        case .rss(let rss):
            return rss.items?.compactMap { feed in
                Episode(podcast: podcast, feedItem: feed)
                } ?? []
        }
    }
}
