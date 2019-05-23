//
//  Podcast+Id.swift
//  PodCastSwift
//
//  Created by tskim on 22/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxDataSources

struct PodcastSection: Equatable {
    var header: String
    var items: [Item]
}

extension PodcastSection: AnimatableSectionModelType {
    typealias Item = Podcast
    
    var identity: String {
        return header
    }
    
    init(original: PodcastSection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension Podcast: IdentifiableType {
    var identity: String {
        return String("\(self.trackId)")
    }
}
