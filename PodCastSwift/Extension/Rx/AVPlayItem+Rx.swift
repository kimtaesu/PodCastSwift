//
//  AVPlayItem+Rx.swift
//  PodCastSwift
//
//  Created by tskim on 24/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import AVKit
import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: AVPlayer {
    var play: Binder<Bool> {
        return Binder(self.base) { player, isPlay in
            if isPlay {
                player.play()
            } else {
                player.pause()
            }
        }
    }
}
