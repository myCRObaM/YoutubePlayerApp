//
//  AlamofireManager.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class AlamofireManager {
    func alamofireRequest(url: String) -> Observable<IndexDataModel> {
        let requestUrl = URL(string: url)!
             
             return Observable.create{   observable -> Disposable in
             
                 Alamofire.request(requestUrl)
                         .responseJSON   { response in
                     do {
                         guard let data = response.data else {return}
                         let video = try JSONDecoder().decode(IndexDataModel.self, from: data)
                         observable.onNext(video)
                     }   catch let jsonErr {
                         observable.onError(jsonErr)
                     }
                 }
                 return Disposables.create()
             }
        
    }
}
