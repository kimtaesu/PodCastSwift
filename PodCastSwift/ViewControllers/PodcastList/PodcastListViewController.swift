//
//  PodcastListViewController.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import ReactorKit
import UIKit

class PodcastListViewController: UIViewController {

    let dataSource = PodcastListDataSource(episode: [])

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let podcastListView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(reactor: PodcastListReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        adapter.do {
            $0.collectionView = podcastListView
            $0.dataSource = dataSource
        }
        podcastListView.do {
            view.addSubview($0)
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.leading.equalTo(safeAreaLeading)
                $0.trailing.equalTo(safeAreaTrailing)
                $0.top.equalTo(safeAreaTop)
                $0.bottom.equalTo(safeAreaBottom)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PodcastListViewController: View, HasDisposeBag {
    func bind(reactor: PodcastListReactor) {
        reactor.state.map { $0.objects }
            .bind {
                self.dataSource.items = $0
                self.adapter.performUpdates(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

final class PodcastListDataSource: NSObject, ListAdapterDataSource {

    var items: [ListDiffable] = []

    init(episode: [ListDiffable]) {
        self.items = episode
    }

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is EpisodeArtWork:
            return EpisodeArtWorkSection()
        default:
            return EpisodeListSection()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
