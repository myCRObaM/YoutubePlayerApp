//
//  AppCoordiantor.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import Shared


class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let indexCoordinator = IndexViewCoordinator(presenter: navigationController)
        self.addCoordinator(coordinator: indexCoordinator)
        indexCoordinator.start()
    }
    
    deinit {
        print("Deinit AppCoordinator")
    }
    
    
}
