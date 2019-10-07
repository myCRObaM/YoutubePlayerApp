//
//  SingleVideoModel.swift
//  YoutubeSingleVideo
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift

class SingleVideoModel {
    
    //MARK: Defining Structs
    struct Input    {
        
    }
    struct Output   {
        var disposables: [Disposable]
    }
    struct Dependencies {
        
    }
    
    //MARK: Variables
    let dependencies: Dependencies
    var input: Input!
    var output: Output!
    
    //MARK: Init
    init(dependencies: SingleVideoModel.Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: Transform
    func transform(input: SingleVideoModel.Input) -> SingleVideoModel.Output {
        self.input = input
        var disposables = [Disposable]()
        
        self.output = Output(disposables: disposables)
        return output
    }
    
}
