//
//  FavoriteViewController.swift
//  PodCastSwift
//
//  Created by tskim on 28/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit

class FavoriteViewController: UIViewController {
 
    let favoritesView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.swiftIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(reactor: FavoriteReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.do {
            $0.rx.setDelegate(self).disposed(by: disposeBag)
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(safeAreaLeading)
                $0.top.equalTo(safeAreaTop)
                $0.bottom.equalTo(safeAreaBottom)
                $0.trailing.equalTo(safeAreaTrailing)
            }
        }
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
}

extension FavoriteViewController: View, HasDisposeBag {
    func bind(reactor: FavoriteReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.fetchFavorites }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
