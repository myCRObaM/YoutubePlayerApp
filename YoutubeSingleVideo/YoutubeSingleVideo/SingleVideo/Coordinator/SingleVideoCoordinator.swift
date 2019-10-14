//
//  SingleVideoCoordinator.swift
//  YoutubeSingleVideo
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import Shared

public class SingleVideoCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    let presenter: UINavigationController
    let viewController: SingleVideoViewController!
    public weak var coordinatorDelegate: ParentCoordinatorDelegate?
    let videoID: String
    
    public init(presenter: UINavigationController, videoID: String) {
        self.presenter = presenter
        self.videoID = videoID
        let model = SingleVideoModel(dependencies: SingleVideoModel.Dependencies(videoID: videoID))
        self.viewController = SingleVideoViewController(viewModel: model)
        viewController.coordinatorDelegate = self
        
    }
    
    public func start() {
        presenter.setNavigationBarHidden(false, animated: false)
        presenter.pushViewController(viewController, animated: false)
    }
}

extension SingleVideoCoordinator: CoordinatorDelegate {
    public func viewControllerHasFinished() {
        presenter.setNavigationBarHidden(true, animated: false)
        self.childCoordinators.removeAll()
        print("SingleVideoCoordinator deinit")
        coordinatorDelegate?.childHasFinished(coordinator: self)
    }
}
