//
//  Favorite.swift
//  PodCastSwift
//
//  Created by tskim on 31/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct FavoriteViewModel {
    let thumbnail: String
    let title: String
    
    init(realmObj: PodcastRealm) {
        thumbnail = realmObj.artworkUrl60
        title = realmObj.artistName
    }
}
