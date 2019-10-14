//
//  IndexViewCoordinator.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import YoutubeSingleVideo
import Shared

class IndexViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let presenter: UINavigationController
    var viewModel: IndexViewModel!
    let indexViewController: IndexViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewModel = IndexViewModel(dependencies: IndexViewModel.Dependencies(scheduler: ConcurrentDispatchQueueScheduler(qos: .background), alamofireRepo: AlamofireRepository()))
        
        self.indexViewController = IndexViewController(viewModel: viewModel)
        
    }
    
    func start() {
        presenter.viewControllers = [indexViewController]
        viewModel.openSingleDelegate = self
    }
    
    deinit {
        print("Index View Coordinator deinit")
    }
    
    
}

extension IndexViewCoordinator: ParentCoordinatorDelegate {
    func childHasFinished(coordinator: Coordinator) {
        self.removeCoordinator(coordinator: coordinator)
    }
}

extension IndexViewCoordinator: OpenSingleDelegate {
    func openVC(videoID: String) {
        let youtubeVideo = SingleVideoCoordinator(presenter: presenter, videoID: videoID)
        self.addCoordinator(coordinator: youtubeVideo)
        youtubeVideo.coordinatorDelegate = self
        youtubeVideo.start()
    }
}
