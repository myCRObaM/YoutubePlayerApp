//
//  IndexViewModelTest.swift
//  YoutubeVideoPlayerTests
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import Nimble
import Quick
import Cuckoo


@testable import YoutubeVideoPlayer

class IndexViewModelTest: QuickSpec {
    override func spec() {
        describe("setup Data"){
            var indexPageData: DataClass!
            var mockedAfRepo = MockAlamofireRepository()
            var testScheduler: TestScheduler!
            var indexViewModel: IndexViewModel!
            let disposeBag = DisposeBag()
            beforeSuite {
                Cuckoo.stub(mockedAfRepo) {mock in
                    let testBundle = Bundle(for: IndexViewModelTest.self)
                    guard let path = testBundle.url(forResource: "IndexTest", withExtension: "json") else {return}
                    let dataFromLocation = try! Data(contentsOf: path)
                    let indexPage = try! JSONDecoder().decode(IndexDataModel.self, from: dataFromLocation)
                    
                    when(mock.requestData()).thenReturn(Observable.just(indexPage))
                    var videoInfoLocal = [VideoInfo]()
                    for video in indexPage.items {
                        let snippet = video.snippet
                        videoInfoLocal.append(VideoInfo(id: video.id, publishedAt: snippet.publishedAt, title: snippet.title, description: snippet.description, thumbnail: snippet.thumbnails.medium.url, channelTitle: snippet.channelTitle))
                    }
                    indexPageData = DataClass(results: indexPage.pageInfo.resultsPerPage, info: videoInfoLocal)
                    
                }
            }
            context("Initialize ViewModel"){
                var dataReadySubject: TestableObserver<Bool>!
                var spinnerSubject: TestableObserver<Bool>!

                beforeEach {
                    testScheduler = TestScheduler(initialClock: 0)
                    indexViewModel = IndexViewModel(dependencies: IndexViewModel.Dependencies(scheduler: testScheduler, alamofireRepo: mockedAfRepo))
                    
                    let input = IndexViewModel.Input(getDataSubject: PublishSubject())
                    let output = indexViewModel.transform(input: input)
                    
                    for disposable in output.disposables {
                        disposable.disposed(by: disposeBag)
                    }
                    
                    dataReadySubject = testScheduler.createObserver(Bool.self)
                    
                    spinnerSubject = testScheduler.createObserver(Bool.self)
                    
                    indexViewModel.output.dataReadySubject.subscribe(dataReadySubject).disposed(by: disposeBag)
                    
                    indexViewModel.output.spinnerSubject.subscribe(spinnerSubject).disposed(by: disposeBag)
                    
                }
                //MARK: Data ready test
                it("check if dataReadySubject is working"){
                    testScheduler.start()
                    
                    indexViewModel.input.getDataSubject.onNext(true)
                    
                    expect(dataReadySubject.events.count).toEventually(equal(1))
                }
                //MARK: Spinner test
                it("check if spinner subject is triggered correctly"){
                    testScheduler.start()
                    indexViewModel.input.getDataSubject.onNext(true)
                    
                    expect(spinnerSubject.events[0].value.element).toEventually(equal(true))
                    expect(spinnerSubject.events[1].value.element).toEventually(equal(false))
                }
                //MARK: Check if data is correctly downloaded
                it("Check if data is correctly downloaded") {
                    testScheduler.start()
                    indexViewModel.input.getDataSubject.onNext(true)
                    
                    expect(indexViewModel.videoData?.videoInfo.count).toEventually(equal(indexPageData.resultsPerPage))
                }
            }
        }
    }
}
