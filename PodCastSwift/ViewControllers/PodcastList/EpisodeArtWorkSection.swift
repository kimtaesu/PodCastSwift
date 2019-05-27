//
//  EpisodeProfileSection.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

final class EpisodeArtWorkSection: ListSectionController {

    var artwork: EpisodeArtWork?

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EpisodeArtWorkCell.self, for: self, at: index) as? EpisodeArtWorkCell else {
            return UICollectionViewCell()
        }
        cell.artistName.text = artwork?.artistName
        cell.artworkUrl.kf.setImage(with: URL(string: artwork?.artworkUrl ?? ""))
        cell.collectionName.text = artwork?.collectionName
        cell.releaseDate.text = artwork?.releaseDate
        cell.trackCount.text = String(artwork?.trackCount ?? 0)
        return cell
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 40)
    }
    
    override func didUpdate(to object: Any) {
        self.artwork = object as? EpisodeArtWork
    }
}
