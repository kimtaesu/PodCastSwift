//
//  PodcastListReactor.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import ReactorKit
import RxSwift

class PodcastListReactor: Reactor, PrintLogReactor {
    let initialState: State
    let podcastService: PodcastServiceType

    init(
        podcast: Podcast,
        service: PodcastServiceType
    ) {
        initialState = State(podcast: podcast)
        self.podcastService = service
        self.action.onNext(.parseEpidsodes)
    }

    enum Action {
        case parseEpidsodes
        case presentEpisode(Int)
        case skipNext
        case skipPrev
    }
    struct State {
        var podcast: Podcast
        var objects: [ListDiffable] = []
        var episodes: [EpisodeItem] = []
        var artwork: EpisodeArtWork
        var currentPlayingEpisode: EpisodeItem?
        var currentPlayingIndex: Int?

        public init(podcast: Podcast) {
            self.podcast = podcast
            self.artwork = EpisodeArtWork(podcast: podcast)
        }

        var message: String?
        var isLoading: Bool?
        var error: Error?
    }
    enum Mutation {
        case setLoading(Bool)
        case setError(Error)
        case currentPlayingEpisode(Int)
        case setEpisodes([EpisodeItem])
        case setMessage(String)
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .skipPrev:
            if let index = currentState.currentPlayingIndex {
                let prevIndex = index - 1
                guard prevIndex > 0  else {
                    return .just(.setMessage(L10n.podcastFirstEpisodeMessage))
                }
                return .just(.currentPlayingEpisode(prevIndex))
            } else {
                return .empty()
            }
        case .skipNext:
            if let index = currentState.currentPlayingIndex {
                let nextIndex = index + 1
                let size = currentState.objects.count
                guard size > nextIndex else {
                    return .just(.setMessage(L10n.podcastLastEpisodeMessage))
                }
                return .just(.currentPlayingEpisode(nextIndex))
            } else {
                return .empty()
            }
        case .presentEpisode(let index):
            return Observable.just(.currentPlayingEpisode(index))
        case .parseEpidsodes:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(self.currentState.podcast)
                    .concatMap { podcast in
                        try self.podcastService.parseEpisodes(url: podcast.feedUrl)
                            .map { $0.map { EpisodeItem(episode: $0, fallbackImage: podcast.artworkUrl600) } }
                    }
                    .map { Mutation.setEpisodes($0) }
                    .catchError { e -> Observable<PodcastListReactor.Mutation> in
                        Observable.just(Mutation.setError(e))
                },
                Observable.just(.setLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .currentPlayingEpisode(let index):
            newState.currentPlayingEpisode = newState.objects[index] as? EpisodeItem
            newState.currentPlayingIndex = index
        case .setError(let e):
            newState.error = e
        case .setEpisodes(let episodes):
            newState.episodes = episodes
            var items: [ListDiffable] = []
            items.append(newState.artwork)
            items.append(contentsOf: newState.episodes)
            newState.objects = items
        case .setLoading(let loading):
            newState.isLoading = loading
        case .setMessage(let msg):
            newState.message = msg
        }
        return newState
    }
}
