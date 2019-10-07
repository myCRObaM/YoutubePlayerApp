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

class IndexViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let presenter: UINavigationController
    let indexViewController: IndexViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.indexViewController = IndexViewController(viewModel: IndexViewModel(dependencies: IndexViewModel.Dependencies(scheduler: ConcurrentDispatchQueueScheduler(qos: .background), alamofireRepo: AlamofireRepository())))
    }
    
    func start() {
        presenter.viewControllers = [indexViewController]
    }
    
    
}
