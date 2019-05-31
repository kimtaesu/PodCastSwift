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
import RealmSwift

class PodcastService: PodcastServiceType {
    let executor: RxDispatcherSchedulersType

    init(_ executor: RxDispatcherSchedulersType = RxDispatcherSchedulers()) {
        self.executor = executor
    }

    func parseEpisodes(podcast: Podcast) throws -> Observable<[Episode]> {
        return Observable.deferred {
            let episodes = try EpisodeParser.parseEpisodes(podcast: podcast)
            return .just(episodes)
        }.subscribeOn(executor.io)
    }
    func saveFavorite(_ podcast: Podcast) -> Observable<Podcast> {
        return Observable.deferred {
            let realm = try Realm()
            try realm.write {
                realm.add(podcast.realmObj)
            }
            return .just(podcast)
        }
    }
    func fetchFavorites() -> Observable<[PodcastRealm]> {
//        let realm = try Realm()
//        let items = Array(realm.objects(PodcastRealm.self))
        return .just([])
    }
}
