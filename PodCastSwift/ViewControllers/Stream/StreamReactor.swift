//
//  StreamReactor.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import AVFoundation
import Foundation
import ReactorKit
import Result
import RxSwift

enum StreamError: Error {
    case notFound
}

class StreamReactor: Reactor, PrintLogReactor {
    let initialState: State

    init(_ episode: EpisodeItem) {
        initialState = State(episode: episode)
    }

    enum Action {
        case setSkipNext
        case setSkipPrev
        case setStatus(AVPlayer.Status)
        case setPlay(Bool)
        case setPlayToggle
        case setSeekBarIsTouching(Bool)
        case periodicTime(CMTime)
        case changeSeekValue(Float)
        case forward
        case backward
        case endPlay
    }
    struct State {
        var isPlay: Bool = false
        var duration: Float64
        var currentSlider: Float
        var currentTime: CMTime
        var status: AVPlayer.Status
        var durationText: String
        var isTouching: Bool = false
        var currentTimeText: String = 0.formatTime
        var thumbnail: URL?
        var playerItem: AVPlayerItem?
        
        var isSkipNext: Bool?
        var isSkipPrev: Bool?
        var endPlay: Bool?
        var seekTime: CMTime?
        
        public init(episode: EpisodeItem) {
            currentSlider = 0
            currentTime = CMTimeMake(value: 0, timescale: 1)
            duration = Double(episode.duration ?? 0)
            if let streamURL = URL(string: episode.streamUrl) {
                playerItem = AVPlayerItem(url: streamURL)
            }
            thumbnail = URL(string: episode.imageUrl ?? "")
            status = AVPlayer.Status.unknown
            durationText = Int(duration).formatTime
        }
        mutating func disposableState() {
            self.isSkipPrev = nil
            self.isSkipNext = nil
            self.endPlay = nil
            self.seekTime = nil
        }
    }
    enum Mutation {
        case setPlay(Bool)
        case setUpdatePeriodic(CMTime)
        case setSeekValue(Float)
        case setSeekBarIsTouching(Bool)
        case setStatus(AVPlayer.Status)
        case setSkipNext
        case setSkipPrev
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setSkipNext:
            return .just(.setSkipNext)
        case .setSkipPrev:
            return .just(.setSkipPrev)
        case .setSeekBarIsTouching(let event):
            return .just(.setSeekBarIsTouching(event))
        case .endPlay:
            return Observable.concat([
                Observable.just(.setPlay(false)),
                Observable.just(Mutation.setSeekValue(0))
                ])

        case .setPlayToggle:
            return .just(.setPlay(!currentState.isPlay))
        case .forward:
            if !currentState.isPlay {
                return .empty()
            }
            let nextSecond = fmin(currentState.currentTime.seconds + 10, currentState.duration)
            let nextTime = CMTime(seconds: nextSecond, preferredTimescale: currentState.currentTime.timescale)
            return Observable.concat([
                Observable.just(Mutation.setSeekValue(nextTime.toValue(duration: currentState.duration))),
                Observable.just(Mutation.setUpdatePeriodic(nextTime))
                ])
        case .backward:
            if !currentState.isPlay {
                return .empty()
            }
            let prevSecond = fmax(currentState.currentTime.seconds - 10, 0)
            let prevTime = CMTime(seconds: prevSecond, preferredTimescale: currentState.currentTime.timescale)
            return Observable.concat([
                Observable.just(Mutation.setSeekValue(prevTime.toValue(duration: currentState.duration))),
                Observable.just(Mutation.setUpdatePeriodic(prevTime))
                ])
        case .setStatus(let status):
            return .just(.setStatus(status))
        case .changeSeekValue(let value):
            return .just(.setSeekValue(value))
        case .setPlay(let play):
            return .just(.setPlay(play))
        case .periodicTime(let time):
            return .just(.setUpdatePeriodic(time))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.disposableState()
        switch mutation {
        case .setSkipPrev:
            newState.isSkipPrev = true
        case .setSkipNext:
            newState.isSkipNext = true
        case .setSeekBarIsTouching(let isTouching):
            newState.isTouching = isTouching
        case .setSeekValue(let value):
            let time = value.toCMTime(duration: currentState.duration)
            newState.seekTime = time
            newState.currentTime = time
        case .setStatus(let status):
            newState.status = status
        case .setPlay(let play):
            newState.isPlay = play
        case .setUpdatePeriodic(let time):
            newState.currentTime = time
            newState.currentTimeText = Int(time.seconds).formatTime
            
            if !newState.isTouching {
                newState.currentSlider = time.toValue(duration: currentState.duration)
            }
        }
        return newState
    }
}

extension Float {
    func toCMTime(duration: Float64) -> CMTime {
        let newValue = Float64(self) * duration
        return CMTimeMakeWithSeconds(newValue, preferredTimescale: Int32(NSEC_PER_SEC))
    }
}

extension CMTime {
    var seconds: Float64 {
        return CMTimeGetSeconds(self)
    }

    func toValue(duration: Float64) -> Float {
        return (Float)(self.seconds / duration)
    }
}
