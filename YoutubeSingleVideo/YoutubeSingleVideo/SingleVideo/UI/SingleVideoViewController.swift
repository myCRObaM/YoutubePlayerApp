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


class SingleVideoViewController: UIViewController, YTPlayerViewDelegate {
    
    //MARK: PlayerView
    let videoPlayer: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
        print(playerView.playlist())
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
    weak var coordinatorDelegate: CoordinatorDelegate?
    
    override func viewDidLoad() {
        setupVideoPlayer()
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinatorDelegate?.viewControllerHasFinished()
        print("SingleVideoViewController deinit")
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
        
        NSLayoutConstraint.activate([
                   videoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
                   videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   videoPlayer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3)
               ])
    }
}
