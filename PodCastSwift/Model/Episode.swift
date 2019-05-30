//
//  PodcastFeed.swift
//  PodCastSwift
//
//  Created by tskim on 21/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import FeedKit
import Foundation
import IGListKit

struct Episode {
    let episode: Int
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    var imageUrl: String?
    let streamUrl: String
    let duration: TimeInterval?
    let size: Int

    public init(
        episode: Int,
        title: String,
        pubDate: Date,
        description: String,
        author: String,
        imageUrl: String?,
        streamUrl: String,
        duration: TimeInterval?,
        size: Int,
        artworkUrl60: String) {
        self.episode = episode
        self.title = title
        self.pubDate = pubDate
        self.description = description
        self.author = author
        self.imageUrl = imageUrl
        self.streamUrl = streamUrl
        self.duration = duration
        self.size = size
    }

    init(podcast: Podcast, feedItem: RSSFeedItem) {
        self.episode = feedItem.iTunes?.iTunesEpisode ?? 0
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? feedItem.iTunes?.iTunesSubtitle ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href ?? podcast.artworkUrl60
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        self.duration = feedItem.iTunes?.iTunesDuration
        self.size = Int(feedItem.enclosure?.attributes?.length ?? 0)
    }
}
