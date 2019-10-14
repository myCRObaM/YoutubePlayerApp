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
    let indexViewController: IndexViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        let viewModel = IndexViewModel(dependencies: IndexViewModel.Dependencies(scheduler: ConcurrentDispatchQueueScheduler(qos: .background), alamofireRepo: YoutubeRepository()))
        let viewController = IndexViewController(viewModel: viewModel)
        self.indexViewController = viewController
        viewModel.openSingleDelegate = self
    }
    
    func start() {
        presenter.pushViewController(indexViewController, animated: true)
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
