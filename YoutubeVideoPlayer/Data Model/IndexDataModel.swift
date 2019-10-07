//
//  IndexDataModel.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation

class IndexDataModel: Decodable {
    let pageInfo: PageInfoModel
    let items: [ItemsModel]
}
struct PageInfoModel: Decodable {
    let resultsPerPage: Int
}
struct ItemsModel: Decodable {
    let id: String
    let snippet: SnippetModel
}

struct SnippetModel: Decodable {
    let publishedAt: String
    let channelID: String
    let title: String
    let description : String
    let thumbnails: ThumbnailsModel
    let channelTitle: String
}

struct ThumbnailsModel: Decodable {
    let medium: MediumThumbNailModel
}
struct MediumThumbNailModel: Decodable {
    let url: String
    let width: Int
    let height: Int
}
