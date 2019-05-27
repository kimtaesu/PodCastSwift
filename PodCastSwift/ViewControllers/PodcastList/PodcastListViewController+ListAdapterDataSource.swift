//
//  PodcastListViewController+.swift
//  PodCastSwift
//
//  Created by tskim on 25/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

extension PodcastListViewController: ListAdapterDataSource, EpisodeListSectionControllerDelegate {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is EpisodeArtWork:
            return EpisodeArtWorkSection()
        default:
            let sectionController = EpisodeListSection()
            sectionController.delegate = self
            return sectionController
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    func presentEpisode(_ sectionController: EpisodeListSection) {
        let index = adapter.section(for: sectionController)
        reactor?.action.onNext(.presentEpisode(index))
    }
}
