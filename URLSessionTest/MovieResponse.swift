//
//  MovieResponse.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/20.
//

import Foundation

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}



// 내가 만들고 싶은 데이터 (우리가 쓰려는 Struct / Class) =======================
struct Movie {
    let movieName: String
    let rank: Int
    
    init(movieNm: String, rank: String) {
        self.movieName = movieNm
        self.rank = Int(rank)!
    }
    
}
