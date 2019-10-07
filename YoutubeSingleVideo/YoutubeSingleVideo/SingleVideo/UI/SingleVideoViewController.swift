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


class SingleVideoViewController: UIViewController {
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
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinatorDelegate?.viewControllerHasFinished()
        super.viewDidDisappear(animated)
    }
}
