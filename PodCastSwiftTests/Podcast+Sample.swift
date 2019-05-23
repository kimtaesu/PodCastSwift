//
//  PodcastSample.swift
//  PodCastSwiftTests
//
//  Created by tskim on 21/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import PodCastSwift

extension PodCastApi {
    var sampleData: Data {
        return ResourcesLoader.readData("sample_poadcast", type: "json")
    }
}
