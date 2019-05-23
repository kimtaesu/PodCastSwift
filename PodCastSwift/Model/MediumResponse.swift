//
//  MediumResponnse.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct MediumResponse: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
