//
//  PodcastService.swift
//  PodCastSwift
//
//  Created by tskim on 26/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class PodcastService: PodcastServiceType {
    
    let executor: RxDispatcherSchedulersType
    
    init(_ executor: RxDispatcherSchedulersType) {
        self.executor = executor
    }
    
    func parseEpisodes(podcast: Podcast) throws -> Observable<[Episode]> {
        return Observable.deferred {
            let episodes = try EpisodeParser.parseEpisodes(podcast: podcast)
            return .just(episodes)
        }.subscribeOn(executor.io)
    }
    func savePodcast(_ podcast: Podcast) {
        
    }
    
}
