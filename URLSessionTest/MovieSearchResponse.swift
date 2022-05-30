//
//  MovieSearchResponse.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import Foundation

struct MovieSearchResponse: Decodable {
    var lastBuildDate: String
    var total: Int
    var start: Int
    var display: Int
    var items: [item]
}


struct item: Decodable {
    var title: String
    var link: String
    var image: String
    var subtitle: String
    var pubDate: String
    var director: String
    var actor: String
    var userRating: String
}
