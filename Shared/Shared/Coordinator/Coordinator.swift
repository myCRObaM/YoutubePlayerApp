//
//  Coordinator.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation

public protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
    func start()
}
public extension Coordinator {
    func addCoordinator(coordinator: Coordinator){
        childCoordinators.append(coordinator)
    }

    func removeCoordinator(coordinator: Coordinator){
        childCoordinators = childCoordinators.filter { $0 !== coordinator}
    }
}
