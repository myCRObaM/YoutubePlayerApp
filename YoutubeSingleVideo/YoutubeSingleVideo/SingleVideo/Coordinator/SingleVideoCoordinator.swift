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
    public weak var coordinatorDelegate: CoordinatorDelegate?
    
   public init(presenter: UINavigationController) {
        self.presenter = presenter
        let model = SingleVideoModel(dependencies: SingleVideoModel.Dependencies())
        self.viewController = SingleVideoViewController(viewModel: model)
        viewController.coordinatorDelegate = coordinatorDelegate
        presenter.setNavigationBarHidden(false, animated: false)
    }
    
    public func start() {
        presenter.pushViewController(viewController, animated: false)
    }
}
