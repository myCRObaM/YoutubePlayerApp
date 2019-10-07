//
//  AlamofireRepository.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift

class AlamofireRepository {
    
    
    let baseURL = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&locale=hr&maxResults=20&key="
    let token = "AIzaSyB_N7m7mEP1cj05iHkXrlAuztYGK8gSeNQ"
    
    func requestData() -> Observable<IndexDataModel> {
            let url = baseURL + token
            let afManager = AlamofireManager()
        return afManager.alamofireRequest(url: url)
    }
}
