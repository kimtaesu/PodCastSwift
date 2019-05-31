//
//  PodcastModel.swift
//  PodCastSwift
//
//  Created by tskim on 30/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RealmSwift

final class PodcastRealm: Object {
    @objc dynamic var trackId: Int = 0
    @objc dynamic var artistName: String = ""
    @objc dynamic var collectionName: String = ""
    @objc dynamic var trackName: String = ""
    @objc dynamic var feedUrl: String? = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var trackCount: Int = 0
    @objc dynamic var primaryGenreName: String = ""
    @objc dynamic var artworkUrl60: String = ""
    @objc dynamic var artworkUrl600: String = ""
}

extension PodcastRealm {
    convenience init(podcast: Podcast) {
        self.init()
        trackId = podcast.trackId
        artistName = podcast.artistName
        collectionName = podcast.collectionName
        trackName = podcast.trackName
        feedUrl = podcast.feedUrl
        releaseDate = podcast.releaseDate
        trackCount = podcast.trackCount
        primaryGenreName = podcast.primaryGenreName
        artworkUrl60 = podcast.artworkUrl60
        artworkUrl600 = podcast.artworkUrl600
    }
}

extension PodcastRealm {
    var toFavorite: FavoriteViewModel {
        return FavoriteViewModel(realmObj: self)
    }
}
