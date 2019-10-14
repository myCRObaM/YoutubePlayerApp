//
//  IndexViewModel.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift


class IndexViewModel {
    //MARK: Defining structs
    struct Input {
        var getDataSubject: ReplaySubject<Bool>
        var openSingleSubject: PublishSubject<Int>
    }
    struct Output {
        var disposables: [Disposable]
        var dataReadySubject: PublishSubject<Bool>
        var spinnerSubject: PublishSubject<Bool>
    }
    struct Dependencies {
        var scheduler: SchedulerType
        var alamofireRepo: YoutubeRepository
    }
    
    //MARK: Variables
    let dependencies: Dependencies
    var input: Input!
    var output: Output!
    var videoData: DataClass?
    weak var openSingleDelegate: OpenSingleDelegate?
    
    //MARK: Init
    init(dependencies: IndexViewModel.Dependencies) {
        self.dependencies = dependencies
    }
    //MARK: Transform
    func transform(input: IndexViewModel.Input) -> IndexViewModel.Output {
        self.input = input
        var disposables = [Disposable]()
        
        disposables.append(getData(subject: input.getDataSubject))
        
        self.output = IndexViewModel.Output(disposables: disposables, dataReadySubject: PublishSubject(), spinnerSubject: PublishSubject())
        return output
    }
    //MARK: GetData
    func getData(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .flatMap({ [unowned self] (bool) -> Observable<IndexDataModel> in
                self.output.spinnerSubject.onNext(true)
                return self.dependencies.alamofireRepo.requestData()
            })
        .observeOn(MainScheduler.instance)
        .subscribeOn(dependencies.scheduler)
        .map({ [unowned self] bool -> DataClass in
            return self.createLocalInfo(data: bool)
            })
        .subscribe(onNext: {[unowned self]  bool in
            self.output.dataReadySubject.onNext(true)
            self.output.spinnerSubject.onNext(false)
            })
    }
    
    func createLocalInfo(data: IndexDataModel) -> DataClass {
        var videoInfoLocal = [VideoInfo]()
        for video in data.items {
            let snippet = video.snippet
            videoInfoLocal.append(VideoInfo(id: video.id, publishedAt: snippet.publishedAt, title: snippet.title, description: snippet.description, thumbnail: snippet.thumbnails.medium.url, channelTitle: snippet.channelTitle))
        }
        let data = DataClass(results: data.pageInfo.resultsPerPage, info: videoInfoLocal)
        self.videoData = data
        return data
    }
}
