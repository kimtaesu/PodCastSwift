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
    
    init(feedItem: RSSFeedItem) {
        self.episode = feedItem.iTunes?.iTunesEpisode ?? 0
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        self.duration = feedItem.iTunes?.iTunesDuration
        
    }
}
