//
//  PodcastCell.swift
//  PodCastSwift
//
//  Created by tskim on 22/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class PodcastCell: UICollectionViewCell, SwiftNameIdentifier {

    struct Metric {
        static let thumbnailWidth: CGFloat = 60
        static let descLeftMargin: CGFloat = 20
    }
    
    let thumbnailView = UIImageView()
    let desctionView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbnailView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                let width = Metric.thumbnailWidth
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
        }
        desctionView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(thumbnailView.snp.trailing).inset(-12)
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
