//
//  iTuneServiceType.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol iTuneServiceType {
    func searchPodcasts(keyword: String) -> Single<[Podcast]>
}
