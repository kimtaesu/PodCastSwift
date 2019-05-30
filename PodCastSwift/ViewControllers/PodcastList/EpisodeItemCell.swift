//
//  EpisodeItemCell.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit
import ExpandableLabel

class EpisodeItemCell: UICollectionViewCell {
    struct Metric {
        static let thumbnailWidth = 60
    }

    let thumbnail: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = ColorName.episodeTitle
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let descView: ExpandableLabel = {
        let label = ExpandableLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.episodeDesc
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.ellipsis = NSAttributedString(string: "...", attributes: [.foregroundColor: ColorName.episodeDescReadMore])
        label.collapsedAttributedLink = NSAttributedString(string: "More", attributes: [.foregroundColor: ColorName.episodeDescReadMore])
        return label
    }()
    let pubDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.episodePubDate
        return label
    }()
    let duration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.episodeDuration
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbnail.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                let width = Metric.thumbnailWidth
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
        }
        pubDate.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(thumbnail.snp.trailing).inset(-12)
                $0.top.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
        
        titleView.do {
            contentView.addSubview($0)
            $0.setContentHuggingPriority(.init(251), for: .vertical)
            $0.snp.makeConstraints {
                $0.leading.equalTo(pubDate.snp.leading)
                $0.top.equalTo(pubDate.snp.bottom)
                $0.trailing.equalToSuperview()
            }
        }
        descView.do {
            $0.setContentHuggingPriority(.init(250), for: .vertical)
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(pubDate.snp.leading)
                $0.top.equalTo(titleView.snp.bottom)
                $0.trailing.equalToSuperview()
            }
        }
        duration.do {
            contentView.addSubview($0)
            $0.setContentHuggingPriority(.init(249), for: .vertical)
            $0.snp.makeConstraints {
                $0.top.equalTo(descView.snp.bottom)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(pubDate.snp.leading)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descView.do {
            $0.collapsed = true
            $0.text = nil
        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
            layoutAttributes.frame = newFrame
        
        return layoutAttributes
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
