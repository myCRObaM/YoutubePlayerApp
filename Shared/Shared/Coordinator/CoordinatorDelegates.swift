//
//  CoordinatorDelegates.swift
//  Shared
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation

public protocol ParentCoordinatorDelegate: class {
    func childHasFinished(coordinator: Coordinator)
}

public protocol CoordinatorDelegate: class {
    func viewControllerHasFinished()
}
