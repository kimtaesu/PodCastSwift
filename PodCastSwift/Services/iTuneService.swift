//
//  iTuneService.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// swiftlint:disable type_name
class iTuneService: iTuneServiceType {

    private let provider: MoyaProvider<PodCastApi>

    init(_ provider: MoyaProvider<PodCastApi>) {
        self.provider = provider
    }

    func searchPodcasts(keyword: String) -> Single<[Podcast]> {
        let reponse: Single<MediumResponse> = self.provider.rx.request(.search(keyword)).unwrap()
        return reponse.map {
            $0.results
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    func unwrap<T: Decodable>() -> Single<T> {
        return filterSuccessfulStatusCodes()
            .map(T.self)
    }
}
