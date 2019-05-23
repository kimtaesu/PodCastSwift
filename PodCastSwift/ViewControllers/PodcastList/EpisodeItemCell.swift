//
//  EpisodeItemCell.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class EpisodeItemCell: UICollectionViewCell {
    
    let titleView = UILabel()
    let descView = UILabel()
    let pubDate = UILabel()
    let author = UILabel()
    let episodeNumber = UILabel()
    let duration = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.top.equalToSuperview()
            }
        }
        descView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(titleView.snp.bottom)
                $0.leading.equalTo(titleView.snp.leading)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
