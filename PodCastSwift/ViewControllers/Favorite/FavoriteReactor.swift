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
    
    init() {
    }
    
    enum Action {
        case fetchFavorites
    }
    struct State {
    }
    enum Mutation {
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchFavorites:
            return .empty()
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
}
