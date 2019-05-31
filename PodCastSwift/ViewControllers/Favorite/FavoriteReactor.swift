//
//  FavoriteReactor.swift
//  PodCastSwift
//
//  Created by tskim on 28/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class FavoriteReactor: Reactor {
    let initialState: State = State()
    let service: PodcastServiceType

    init(_ service: PodcastServiceType) {
        self.service = service
    }

    enum Action {
        case fetchFavorites
    }
    struct State {
        var isLoading: Bool?
        var favorites: [FavoriteViewModel]

        public init() {
            self.favorites = []
        }
    }
    enum Mutation {
        case setLoading(Bool)
        case setFavorites([FavoriteViewModel])
    }
    func mutate(action: Action) -> Observable<Mutation> {
        self.service.fetchFavorites().map { $0.toFavorite }
        switch action {
        case .fetchFavorites:
            return Observable.concat([
                    .just(.setLoading(true)),
                    .just(.setLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let loading):
            newState.isLoading = loading
        case .setFavorites(let favorite):
            newState.favorites = favorite
        }
        return newState
    }
}
