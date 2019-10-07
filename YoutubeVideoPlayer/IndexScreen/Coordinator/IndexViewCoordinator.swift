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
import Shared

class IndexViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let presenter: UINavigationController
    let indexViewController: IndexViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        let viewModel = IndexViewModel(dependencies: IndexViewModel.Dependencies(scheduler: ConcurrentDispatchQueueScheduler(qos: .background), alamofireRepo: AlamofireRepository()))
        viewModel.openSingleDelegate = self
        self.indexViewController = IndexViewController(viewModel: viewModel)
    }
    
    func start() {
        presenter.viewControllers = [indexViewController]
    }
    
    
}

extension IndexViewCoordinator: CoordinatorDelegate, ParentCoordinatorDelegate {
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        childHasFinished(coordinator: self)
    }
    
    func childHasFinished(coordinator: Coordinator) {
        self.removeCoordinator(coordinator: coordinator)
    }
    
    
}

extension IndexViewCoordinator: OpenSingleDelegate {
    func openVC(videoID: String) {
        let singleCoordinator = SingleVideo
    }
}
