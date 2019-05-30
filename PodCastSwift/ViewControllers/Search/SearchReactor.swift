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
        case itemSelected(IndexPath)
        case setKeyword(String?)
    }
    
    struct State {
        var podcastSections: [PodcastSection]

        public init(podcastSections: [PodcastSection]) {
            self.podcastSections = podcastSections
        }
        
        var isLoading: Bool?
        var error: Error?
        var selectedItem: Podcast?
        
        mutating func disposeState() {
            selectedItem = nil
            error = nil
            isLoading = nil
        }
    }
    enum Mutation {
        case setPodcasts([Podcast])
        case setLoading(Bool)
        case setError(Error)
        case setItemSelected(Podcast)
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setKeyword(let keyword):
//            guard let keyword = keyword, keyword.isNotEmpty else { return .empty() }
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.iTuneService
                    .searchPodcasts(keyword: "asd")
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
        case .itemSelected(let ip):
            let item = currentState.podcastSections[ip.section].items[ip.row]
            return .just(Mutation.setItemSelected(item))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.disposeState()
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
