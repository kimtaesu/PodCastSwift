//
//  PodcastService.swift
//  PodCastSwift
//
//  Created by tskim on 26/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

class PodcastService: PodcastServiceType {
    func parseEpisodes(url: String?) throws -> Observable<[Episode]> {
        let episodes = try EpisodeParser.parseEpisodes(url: url)
        return .just(episodes)
    }
}
