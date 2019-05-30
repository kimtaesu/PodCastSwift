//
//  PodcastServiceType.swift
//  PodCastSwift
//
//  Created by tskim on 30/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol PodcastServiceType {
    func parseEpisodes(podcast: Podcast) throws -> Observable<[Episode]>
    
    func savePodcast(_ podcast: Podcast)
}
