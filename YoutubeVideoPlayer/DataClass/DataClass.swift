//
//  DataClass.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
class DataClass {
    var resultsPerPage: Int
    var videoInfo: [VideoInfo]
    init(results: Int, info: [VideoInfo]) {
        self.resultsPerPage = results
        self.videoInfo = info
    }
}
struct VideoInfo {
    var id: String
    var publishedAt: String
    var title: String
    var description: String
    var thumbnail: String
    var channelTitle: String
}
