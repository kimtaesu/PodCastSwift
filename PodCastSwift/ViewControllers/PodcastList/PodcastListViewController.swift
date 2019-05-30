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
import Toaster
import UIKit

class PodcastListViewController: UIViewController {

    var items: [ListDiffable] = []

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let favoriteBarButton = UIBarButtonItem(image: Asset.icFavorite24pt.image, style: .done, target: nil, action: nil)
    let podcastListView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = favoriteBarButton
    }

    init(reactor: PodcastListReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        adapter.do {
            $0.collectionView = podcastListView
            $0.dataSource = self
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
                self.items = $0
                self.adapter.performUpdates(animated: true)
            }
            .disposed(by: disposeBag)

        favoriteBarButton.rx.tap
            .map { Reactor.Action.tapsFavorite }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.message }
            .filterNil()
            .bind { Toast(text: $0).show() }
            .disposed(by: disposeBag)

        reactor.state.map { $0.navTitle }
            .distinctUntilChanged()
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        reactor.state.map { $0.currentPlayingEpisode }
            .filterNil()
            .distinctUntilChanged()
            .bind { [weak self] episode in
                guard let self = self else { return }
                if let streamViewConntroller = self.presentedViewController as? StreamViewController {
                    streamViewConntroller.replaceReactor(StreamReactor(episode))
                } else {
                    let vc = StreamViewController(
                        reactor: StreamReactor(episode),
                        skipNext: { reactor.action.onNext(.skipNext) },
                        skipPrev: { reactor.action.onNext(.skipPrev) }
                    )
                    self.present(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
