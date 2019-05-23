//
//  SearchReactor.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class SearchReactor: Reactor {
    let initialState: State
    let iTuneService: iTuneServiceType

    init(_ service: iTuneServiceType) {
        self.iTuneService = service
        initialState = State(podcastSections: [])
    }

    enum Action {
        case refresh
        case itemSelected(IndexPath)
    }
    
    struct State {
        var podcastSections: [PodcastSection]

        public init(podcastSections: [PodcastSection]) {
            self.podcastSections = podcastSections
        }
        
        var isLoading: Bool?
        var error: Error?
        var selectedItem: Podcast?
    }
    enum Mutation {
        case setPodcasts([Podcast])
        case setLoading(Bool)
        case setError(Error)
        case setItemSelected(Podcast)
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .itemSelected(let ip):
            let item = currentState.podcastSections[ip.section].items[ip.row]
            return .just(Mutation.setItemSelected(item))
        case .refresh:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.iTuneService
                    .searchPodcasts(keyword: "Jone")
                    .asObservable()
                    .map {
                        Mutation.setPodcasts($0)
                    }
                    .catchError({ error in
                        logger.error(error)
                        return .just(Mutation.setError(error))
                    }),
                Observable.just(Mutation.setLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setItemSelected(let item):
            newState.selectedItem = item
        case .setError(let error):
            newState.error = error
        case .setPodcasts(let podcasts):
            newState.podcastSections = [PodcastSection(header: "podcasts", items: podcasts)]
        case .setLoading(let loading):
            newState.isLoading = loading
        }
        return newState
    }
}
