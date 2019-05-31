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
    }

    let thumbnailView = UIImageView()
    
    let genre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let trackCount: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let trackName: UILabel = {
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
        artistName.do {
            contentView.addSubview($0)
            $0.setContentCompressionResistancePriority(.init(251), for: .vertical)
            $0.snp.makeConstraints {
                $0.leading.equalTo(thumbnailView.snp.trailing).inset(-12)
                $0.top.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
        trackName.do {
            contentView.addSubview($0)
            $0.setContentCompressionResistancePriority(.init(250), for: .vertical)
            $0.snp.makeConstraints {
                $0.leading.equalTo(artistName.snp.leading)
                $0.top.equalTo(artistName.snp.bottom)
                $0.trailing.equalToSuperview()
            }
        }
        genre.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(artistName.snp.leading)
                $0.top.equalTo(trackName.snp.bottom)
                $0.trailing.equalToSuperview()
            }
        }
        trackCount.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(artistName.snp.leading)
                $0.trailing.equalToSuperview()
                $0.top.equalTo(genre.snp.bottom)
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
