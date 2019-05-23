//
//  PodcastCell.swift
//  PodCastSwift
//
//  Created by tskim on 22/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class PodcastCell: UITableViewCell, SwiftNameIdentifier {
    
    let thumbnailView = UIImageView()
    let trackName = UILabel()
    let artist = UILabel()
    let trackCount = UILabel()
    let genres = UILabel()
    // TODO rating count
    // TODO Suggestion
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        thumbnailView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                let width = 50
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
        }
        trackName.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(thumbnailView.snp.trailing)
                $0.top.equalToSuperview()
            }
        }
        artist.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(trackName.snp.leading)
                $0.top.equalTo(trackName.snp.bottom)
            }
        }
        trackCount.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(trackName.snp.leading)
                $0.top.equalTo(artist.snp.bottom)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
