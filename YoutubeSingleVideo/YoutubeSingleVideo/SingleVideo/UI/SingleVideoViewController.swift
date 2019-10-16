//
//  SingleVideoViewController.swift
//  YoutubeSingleVideo
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import Shared
import youtube_ios_player_helper
import SnapKit


class SingleVideoViewController: UIViewController, YTPlayerViewDelegate {
    
    //MARK: PlayerView
    let videoPlayer: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    //MARK: INIT
    init(viewModel: SingleVideoModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Variables
    var viewModel: SingleVideoModel!
    let disposeBag = DisposeBag()
    weak var coordinatorDelegate: CoordinatorDelegate?
    
    override func viewDidLoad() {
        setupViewModel()
        viewModel.input.setupData.onNext(true)
        super.viewDidLoad()
    }
    
    func setupViewModel() {
        let input = SingleVideoModel.Input(setupData: ReplaySubject<Bool>.create(bufferSize: 1))
        
        let output = viewModel.transform(input: input)
        
        for disposable in output.disposables {
            disposable.disposed(by: disposeBag)
        }
        
        output.dataReady
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(onNext: {[unowned self]  bool in
            self.setupVideoPlayer()
        }).disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinatorDelegate?.viewControllerHasFinished()
        print("SingleVideoViewController deinit")
        videoPlayer.pauseVideo()
        super.viewDidDisappear(animated)
    }
    //MARK: Setup Video Player
    func setupVideoPlayer(){
        view.addSubview(videoPlayer)
        view.backgroundColor = .white
        
        videoPlayer.delegate = self
        
        videoPlayer.load(withVideoId: viewModel.dependencies.videoID)
        setupConstraints()
    }
    //MARK: Setup Constraints
    func setupConstraints(){
        videoPlayer.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(view)
            make.height.equalTo(UIScreen.main.bounds.height/3)
        }
    }
}
