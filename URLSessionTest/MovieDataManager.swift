//
//  MovieDataManager.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/20.
//

import Foundation

class MovieDataManager {
    
    let movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    
    let myKey = "b4d2c860bdd937f0186339b3082437a1"
    
    func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(movieURL)&key=\(myKey)&targetDt=\(date)"
        
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            
            // 데이터 파싱하기
            if let movies = self.parseJSON(safeData) {
                completion(movies)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // JSON 데이터를 파싱해서 반환하는 함수
    func parseJSON(_ movieData: Data) -> [Movie]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData: MovieData = try decoder.decode(MovieData.self, from: movieData)
            
            let dailyLists: [DailyBoxOfficeList] = decodedData.boxOfficeResult.dailyBoxOfficeList
            
            let myMovielists: [Movie] = dailyLists.map {
                Movie(movieNm: $0.movieNm, rank: $0.rank)
            }
            
            return myMovielists
            
        } catch {
            print("파싱 실패")
            
            return nil
        }
        
    }
    
}
