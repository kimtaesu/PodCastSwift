//
//  SearchViewController.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class SearchViewController: UIViewController {

    let searchPodcastView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: PodcastCell.swiftIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.hidesBottomBarWhenPushed = true
        return search
    }()
    let dataSource = dataSourceFactory()

    private static func dataSourceFactory() -> RxCollectionViewSectionedAnimatedDataSource<PodcastSection> {
        return .init(
            configureCell: { dataSource, cv, indexPath, item in
                guard let cell: PodcastCell = cv.dequeueReusableCell(withReuseIdentifier: PodcastCell.swiftIdentifier, for: indexPath) as? PodcastCell else { return UICollectionViewCell() }
                cell.trackCount.text = "\(item.trackCount)"
                cell.artistName.text = item.artistName
                cell.trackName.text = item.trackName
                cell.genre.text = item.primaryGenreName
                cell.thumbnailView.kf.setImage(with: URL(string: item.artworkUrl60))
                return cell
            }
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(
        reactor: SearchReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        searchPodcastView.do {
            view.addSubview($0)
            $0.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            $0.rx.setDelegate(self).disposed(by: disposeBag)
            $0.snp.makeConstraints {
                $0.leading.equalTo(safeAreaLeading)
                $0.trailing.equalTo(safeAreaTrailing)
                $0.top.equalTo(safeAreaTop)
                $0.bottom.equalTo(safeAreaBottom)
            }
        }
    }
}

extension SearchViewController: View, HasDisposeBag {
    func bind(reactor: SearchReactor) {
        searchController.searchBar.rx.text
            .debounce(0.5, scheduler: MainScheduler.asyncInstance)
            .map { Reactor.Action.setKeyword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.searchPodcastView.rx.itemSelected
            .map { Reactor.Action.itemSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.podcastSections }
            .bind(to: searchPodcastView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        reactor.state.map { $0.selectedItem }
            .filterNil()
            .bind { [weak self] podcast in
                guard let self = self else { return }
                let reactor = PodcastListReactor(podcast: podcast, service: PodcastService(RxDispatcherSchedulers()))
                self.navigationController?.pushViewController(PodcastListViewController(reactor: reactor), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PodcastCell else { return }
        cell.thumbnailView.kf.cancelDownloadTask()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
        let sectionInset = collectionViewLayout.sectionInset
        let referenceHeight: CGFloat = 100 // Approximate height of your cell
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}
