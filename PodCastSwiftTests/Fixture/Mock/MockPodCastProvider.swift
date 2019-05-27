//
//  AA.swift
//  PodCastSwiftTests
//
//  Created by tskim on 21/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya
@testable import PodCastSwift

class MockPodCastProvider {

    private static var sampleEndPoint: (PodCastApi) -> Endpoint {
        return { (target: PodCastApi) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, ResourcesLoader.readData("sample_podcast", type: "json")) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers)
        }
    }
    private static var error401Endpoint: (PodCastApi) -> Endpoint {
        return { (target: PodCastApi) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(401, "".data(using: .utf8)!) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
    }
    static func sample() -> MoyaProvider<PodCastApi> {
        return MoyaProvider<PodCastApi>(endpointClosure: sampleEndPoint, stubClosure: MoyaProvider.immediatelyStub)
    }
    static func error401() -> MoyaProvider<PodCastApi> {
        return MoyaProvider<PodCastApi>(endpointClosure: error401Endpoint, stubClosure: MoyaProvider.immediatelyStub)
    }

}
