//
//  Podcast+PodcastRealm.swift
//  PodCastSwift
//
//  Created by tskim on 30/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension Podcast {
    var realmObj: PodcastRealm {
        return PodcastRealm(podcast: self)
    }
}
