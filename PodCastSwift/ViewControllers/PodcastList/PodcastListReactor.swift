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

class PodcastListReactor: Reactor {
    let initialState: State

    init(_ podcast: Podcast) {
        var state = State(podcast: podcast, objects: [])
        state.objects.append(EpisodeArtWork(podcast: podcast))
        initialState = state
        self.action.onNext(.parseEpidsodes)
    }

    enum Action {
        case parseEpidsodes
    }
    struct State {
        var podcast: Podcast
        var objects: [ListDiffable] = []

        public init(podcast: Podcast, objects: [ListDiffable] = []) {
            self.podcast = podcast
            self.objects = objects
        }

        var isLoading: Bool?
        var error: Error?
    }
    enum Mutation {
        case setLoading(Bool)
        case setError(Error)
        case setEpisodes([EpisodeItem])
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .parseEpidsodes:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(self.currentState.podcast)
                    .map { try $0.parseEpisodes().map { EpisodeItem(episode: $0) } }
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
        case .setError(let e):
            newState.error = e
        case .setEpisodes(let episodes):
            newState.objects = episodes
        case .setLoading(let loading):
            newState.isLoading = loading
        }
        return newState
    }
}
