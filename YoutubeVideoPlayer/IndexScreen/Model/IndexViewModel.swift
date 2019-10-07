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
        var getDataSubject: PublishSubject<Bool>
    }
    struct Output {
        var disposables: [Disposable]
        var dataReadySubject: PublishSubject<Bool>
    }
    struct Dependencies {
        var scheduler: SchedulerType
        var alamofireRepo: AlamofireRepository
    }
    //MARK: Variables
    let dependencies: Dependencies
    var input: Input!
    var output: Output!
    var videoData: DataClass?
    
    //MARK: Init
    init(dependencies: IndexViewModel.Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: IndexViewModel.Input) -> IndexViewModel.Output {
        self.input = input
        var disposables = [Disposable]()
        
        disposables.append(getData(subject: input.getDataSubject))
        
        self.output = IndexViewModel.Output(disposables: disposables, dataReadySubject: PublishSubject())
        return output
    }
    
    func getData(subject: PublishSubject<Bool>) -> Disposable {
        return subject
            .flatMap({ [unowned self] (bool) -> Observable<IndexDataModel> in
                return self.dependencies.alamofireRepo.requestData()
            })
        .observeOn(MainScheduler.instance)
        .subscribeOn(dependencies.scheduler)
        .map({ bool -> DataClass in
            var videoInfoLocal = [VideoInfo]()
            for video in bool.items {
                let snippet = video.snippet
                videoInfoLocal.append(VideoInfo(id: video.id, publishedAt: snippet.publishedAt, title: snippet.title, description: snippet.description, thumbnail: snippet.thumbnails.medium.url, channelTitle: snippet.channelTitle))
            }
            return DataClass(results: bool.pageInfo.resultsPerPage, info: videoInfoLocal)
            })
        .subscribe(onNext: {[unowned self]  bool in
            self.videoData = bool
            })
    }
}
