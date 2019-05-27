//
//  StreamViewController.swift
//  PodCastSwift
//
//  Created by tskim on 23/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import AVKit
import Foundation
import ReactorKit
import UIKit
import RxSwift

class PodcastPlayer {
    static let shared = AVPlayer()
}

class StreamViewController: UIViewController {

    let player = PodcastPlayer.shared
    var disposeBag = DisposeBag()

    let skipNextCallback: () -> Void
    let skipPrevCallback: () -> Void
    let seekbar: UISlider = {
        let slider = UISlider()
        slider.tintColor = ColorName.colorAccent
        slider.thumbTintColor = ColorName.colorLight
        return slider
    }()

    let currentSeekTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    let endSeekTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        return thumbnail
    }()

    let forward: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icForward.image, for: .normal)
        return button
    }()

    let backward: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icBackward.image, for: .normal)
        return button
    }()

    let playButton: UIButton = {
        let button = UIButton()
        return button
    }()

    let skipNext: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icSkipNext.image, for: .normal)
        return button
    }()

    let skipPrev: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icSkipPrev.image, for: .normal)
        return button
    }()

    init(
        reactor: StreamReactor,
        skipNext: @escaping () -> Void,
        skipPrev: @escaping () -> Void
    ) {
        defer { self.reactor = reactor }
        self.skipNextCallback = skipNext
        self.skipPrevCallback = skipPrev
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        thumbnail.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                let width = view.frame.width
                $0.leading.equalTo(safeAreaLeading)
                $0.top.equalTo(safeAreaTop)
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
        }
        seekbar.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(safeAreaLeading).offset(15)
                $0.center.equalToSuperview()
            }
        }
        currentSeekTime.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(seekbar.snp.leading)
                $0.top.equalTo(seekbar.snp.bottom)
            }
        }
        playButton.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.bottom.equalTo(safeAreaBottom)
                $0.centerX.equalToSuperview()
            }
        }
        skipNext.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.centerY.equalTo(playButton.snp.centerY)
            }
        }
        skipPrev.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalTo(playButton.snp.centerY)
            }
        }
        endSeekTime.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.trailing.equalTo(seekbar.snp.trailing)
                $0.top.equalTo(seekbar.snp.bottom)
            }
        }
        forward.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(thumbnail.snp.centerY)
                $0.trailing.equalTo(thumbnail.snp.trailing)
            }
        }
        backward.do {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(thumbnail.snp.centerY)
                $0.leading.equalTo(thumbnail.snp.leading)
            }
        }
    }
}

extension StreamViewController: View {
    func replaceReactor(_ reactor: StreamReactor) {
        disposeBag = DisposeBag()
        self.seekbar.value = 0
        self.player.seek(to: CMTime(value: 0, timescale: 1))
        self.player.cancelPendingPrerolls()
        self.player.pause()
        self.reactor = reactor
        self.reactor?.action.onNext(.setPlay(true))
    }
    // swiftlint:disable function_body_length
    func bind(reactor: StreamReactor) {
        skipNext.rx.tap
            .map { Reactor.Action.setSkipNext }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        skipPrev.rx.tap
            .map { Reactor.Action.setSkipPrev }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        seekbar.rx.controlEvent(.touchDown)
            .map { Reactor.Action.setSeekBarIsTouching(true) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        seekbar.rx.controlEvent(.touchUpInside)
            .map { Reactor.Action.setSeekBarIsTouching(false) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        seekbar.rx.value
            .map { Reactor.Action.changeSeekValue($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.setPlay(true) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        player.rx.periodicTimeObserver(interval: CMTime(value: 1, timescale: 1))
            .map { Reactor.Action.periodicTime($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        player.rx.status
            .map { Reactor.Action.setStatus($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        forward.rx.tap
            .map { Reactor.Action.forward }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        backward.rx.tap
            .map { Reactor.Action.backward }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        NotificationCenter.default.rx.notification(NSNotification.Name.AVPlayerItemDidPlayToEndTime)
            .map { _ in Reactor.Action.endPlay }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        playButton.rx.tap
            .map { Reactor.Action.setPlayToggle }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.playerItem }
            .distinctUntilChanged()
            .bind { [weak self] item in
                guard let self = self else { return }
                self.player.replaceCurrentItem(with: item)
                self.player.play()
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.seekTime }
            .filterNil()
            .distinctUntilChanged()
            .bind {
                self.player.seek(to: $0)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.isPlay }
            .distinctUntilChanged()
            .bind {
                if $0 {
                    self.playButton.setImage(Asset.icPause.image, for: .normal)
                } else {
                    self.playButton.setImage(Asset.icPlay.image, for: .normal)
                }
            }
            .disposed(by: disposeBag)
        reactor.state.map { $0.isPlay }
            .distinctUntilChanged()
            .bind(to: self.player.rx.play)
            .disposed(by: disposeBag)

        reactor.state.map { $0.durationText }
            .distinctUntilChanged()
            .bind(to: endSeekTime.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.currentSlider }
            .distinctUntilChanged()
            .bind(to: self.seekbar.rx.value)
            .disposed(by: disposeBag)

        reactor.state.map { $0.thumbnail }
            .distinctUntilChanged()
            .bind { [weak self] url in
                guard let self = self else { return }
                self.thumbnail.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.currentTimeText }
            .bind(to: currentSeekTime.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isSkipPrev }
            .filter { $0 == true }
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.skipPrevCallback()
            }
            .disposed(by: disposeBag)
        reactor.state.map { $0.isSkipNext }
            .filter { $0 == true }
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.skipNextCallback()
            }
            .disposed(by: disposeBag)
    }
}
