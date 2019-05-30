//
//  EpisodeListSection.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ExpandableLabel
import Foundation
import IGListKit
import UIKit

protocol EpisodeListSectionControllerDelegate: class {
    func presentEpisode(_ sectionController: EpisodeListSection)
}
final class EpisodeListSection: ListSectionController {

    var item: EpisodeItem?
    weak var delegate: EpisodeListSectionControllerDelegate?

    override init() {
        super.init()
//        Automatic cell does not apply left, right
        inset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EpisodeItemCell.self, for: self, at: index) as? EpisodeItemCell else {
            return UICollectionViewCell()
        }
        cell.thumbnail.kf.setImage(with: URL(string: item?.imageUrl ?? ""))
        cell.titleView.text = item?.title
        cell.descView.do {
            $0.layoutIfNeeded()
            $0.text = item?.desc
            $0.shouldCollapse = true
            $0.collapsed = true
        }
        cell.duration.text = Int(item?.duration ?? 0).formatTime
        
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else {
            return CGSize(width: 0, height: 0)
        }
        let width = collectionContext.containerSize.width - self.inset.left - self.inset.right
        return CGSize(width: width, height: 80)
    }
    override func didUpdate(to object: Any) {
        self.item = object as? EpisodeItem
    }
    override func didSelectItem(at index: Int) {
//        delegate?.presentEpisode(self)
    }
    
}
