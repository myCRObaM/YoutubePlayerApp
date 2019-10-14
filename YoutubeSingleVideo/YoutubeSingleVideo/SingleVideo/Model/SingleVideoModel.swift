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
        var setupData: ReplaySubject<Bool>
    }
    struct Output   {
        var videoID: String
        var disposables: [Disposable]
        var dataReady: ReplaySubject<Bool>
    }
    struct Dependencies {
        var videoID: String
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
        
        disposables.append(setupData(subject: input.setupData))
        
        self.output = Output(videoID: dependencies.videoID, disposables: disposables, dataReady: ReplaySubject<Bool>.create(bufferSize: 1))
        return output
    }
    
    func setupData(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(onNext: {[unowned self]  bool in
            self.output.dataReady.onNext(true)
        })
    }
    
}
