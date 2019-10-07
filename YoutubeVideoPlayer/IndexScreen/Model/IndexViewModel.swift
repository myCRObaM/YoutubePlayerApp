//
//  IndexViewModel.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
class IndexViewModel {
    //MARK: Defining structs
    struct Input {
        
    }
    struct Output {
        
    }
    struct Dependencies {
        
    }
    //MARK: Variables
    let dependencies: Dependencies
    var input: Input!
    var output: Output!
    
    //MARK: Init
    init(dependencies: IndexViewModel.Dependencies) {
        self.dependencies = dependencies
    }
}
