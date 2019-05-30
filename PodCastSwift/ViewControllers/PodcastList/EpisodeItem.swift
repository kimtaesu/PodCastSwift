//
//  EpisodeItem.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

final class EpisodeItem: NSObject {
    let title: String
    let pubDate: Date
    let desc: String
    let author: String
    let streamUrl: String
    let imageUrl: String?
    let duration: TimeInterval?

    public init(episode: Episode, fallbackImage: String) {
        self.imageUrl = episode.imageUrl ?? fallbackImage
        self.title = episode.title
        self.pubDate = episode.pubDate
        self.desc = episode.description
        self.author = episode.author
        self.streamUrl = episode.streamUrl
        self.duration = episode.duration
    }
    
    override var description: String {
        return """
        \(self.title)
        """
    }
}

extension EpisodeItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? EpisodeItem else { return false }
        return self.isEqual(toDiffableObject: object)
    }
}
