//
//  EpisodeListSection.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

protocol EpisodeListSectionControllerDelegate: class {
    func presentEpisode(_ sectionController: EpisodeListSection)
}
final class EpisodeListSection: ListSectionController {

    var item: EpisodeItem?
    weak var delegate: EpisodeListSectionControllerDelegate?

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EpisodeItemCell.self, for: self, at: index) as? EpisodeItemCell else {
            return UICollectionViewCell()
        }
        cell.author.text = item?.author
        cell.descView.text = item?.desc
        cell.episodeNumber.text = String(describing: item?.episodeNumber)
        // TODO
//        cell.pubDate.text = item?.pubDate

        cell.duration.text = String(describing: item?.duration)
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 40)
    }
    override func didUpdate(to object: Any) {
        self.item = object as? EpisodeItem
    }
    override func didSelectItem(at index: Int) {
        delegate?.presentEpisode(self)
    }
}
