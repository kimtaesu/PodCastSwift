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
import UIKit

class SearchViewController: UIViewController {

    let searchPodcastView: UITableView = {
        let tableView = UITableView()
        tableView.register(PodcastCell.self, forCellReuseIdentifier: PodcastCell.swiftIdentifier)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
    }()

    let dataSource = dataSourceFactory()

    private static func dataSourceFactory() -> RxTableViewSectionedAnimatedDataSource<PodcastSection> {
        return .init(
            configureCell: { dataSource, tableView, indexPath, item in
                guard let cell: PodcastCell = tableView.dequeueReusableCell(withIdentifier: PodcastCell.swiftIdentifier, for: indexPath) as? PodcastCell else { return UITableViewCell() }
                cell.artist.text = item.artistName
                cell.trackName.text = item.trackName
                cell.trackCount.text = String(item.trackCount)
                cell.genres.text = item.primaryGenreName
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchPodcastView.do {
            view.addSubview($0)
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
        self.searchPodcastView.rx.itemSelected
            .map { Reactor.Action.itemSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.podcastSections }
            .bind(to: searchPodcastView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        reactor.state.map { $0.selectedItem }
            .filterNil()
            .bind { [weak self] podcast in
                let reactor = PodcastListReactor(podcast)
                self?.show(PodcastListViewController(reactor: reactor), sender: nil)
            }
            .disposed(by: disposeBag)

    }
}
