//
//  EpisodeProfile.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

final class EpisodeArtWork: NSObject {
    let trackId: Int
    let artworkUrl: String
    let trackCount: Int
    let releaseDate: String
    let artistName: String
    let collectionName: String

    public init(podcast: Podcast) {
        self.trackId = podcast.trackId
        self.artworkUrl = podcast.artworkUrl600
        self.trackCount = podcast.trackCount
        self.releaseDate = podcast.releaseDate
        self.artistName = podcast.artistName
        self.collectionName = podcast.collectionName
    }
}

extension EpisodeArtWork: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.trackId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? EpisodeArtWork else { return false }
        return self.isEqual(toDiffableObject: object)
    }
}
