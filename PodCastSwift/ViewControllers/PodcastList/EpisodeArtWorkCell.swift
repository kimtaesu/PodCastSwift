//
//  EpisodeProfileCell.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class EpisodeArtWorkCell: UICollectionViewCell {
    
    let artworkUrl = UIImageView()
    let trackCount = UILabel()
    let releaseDate = UILabel()
    let artistName = UILabel()
    let collectionName = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        artworkUrl.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.width.equalTo(100)
                $0.height.equalTo(100)
                $0.top.equalToSuperview()
            }
        }
        trackCount.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(artworkUrl.snp.bottom)
                $0.leading.equalTo(artworkUrl.snp.leading)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
