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

final class EpisodeListSection: ListSectionController {

    var item: EpisodeItem?
    
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
    
    override func didUpdate(to object: Any) {
        self.item = object as? EpisodeItem
    }
}
