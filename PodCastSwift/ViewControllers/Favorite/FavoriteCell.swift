//
//  FavoriteCell.swift
//  PodCastSwift
//
//  Created by tskim on 28/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCell: UICollectionViewCell, SwiftNameIdentifier {
    
    struct Metric {
        static let thumbnailWidth = 60
    }
    let thumbnail = UIImageView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbnail.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                let width = Metric.thumbnailWidth
                $0.width.equalTo(width)
                $0.height.equalTo(width)
                $0.leading.equalToSuperview()
                $0.top.equalToSuperview()
            }
        }
        title.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(thumbnail.snp.bottom)
                $0.leading.equalTo(thumbnail.snp.leading)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
