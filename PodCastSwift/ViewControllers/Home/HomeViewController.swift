//
//  HomeViewController.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import UIKit

class HomeViewController: UITabBarController {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(reactor: HomeReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)

        viewControllers = reactor.createTabbarViewControllers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: View, HasDisposeBag {
    func bind(reactor: HomeReactor) {

    }
}
