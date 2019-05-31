//
//  HomeReactor.swift
//  PodCastSwift
//
//  Created by tskim on 28/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class HomeReactor: Reactor {
    let initialState: State = State()
    let iTunesService: iTuneServiceType

    init(_ service: iTuneServiceType) {
        self.iTunesService = service
    }

    enum Action {
    }
    struct State {
    }
    enum Mutation {
    }
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }

    func createTabbarViewControllers() -> [UIViewController] {
        return [
            UINavigationController(rootViewController: FavoriteViewController(reactor: FavoriteReactor(PodcastService())).then {
                $0.tabBarItem.title = "Favorites"
                $0.tabBarItem.image = Asset.icFavorite24pt.image
            }),
            UINavigationController(rootViewController: SearchViewController(reactor: SearchReactor(self.iTunesService)).then {
                $0.tabBarItem.title = "Search"
                $0.tabBarItem.image = Asset.icSearch24pt.image
            }),
            UINavigationController(rootViewController: DownloadViewController().then {
                $0.tabBarItem.title = "Downloads"
                $0.tabBarItem.image = Asset.icDownload24pt.image
            })
        ]
    }
}
