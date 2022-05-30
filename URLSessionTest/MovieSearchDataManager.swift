//
//  MovieSearchDataManager.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import Foundation

class MovieSearchDataManager {
    
    let searchURL = "https://openapi.naver.com/v1/search/movie.json"
    
    let myKey = NaverKey.naverKey
    
    func fetchMovie(searchKeyword: String, completion: @escaping ([SearchedMovie]?) -> Void) {
        
        // 한글 인코딩
        let encodedMovieTitle = searchKeyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let urlString = "\(searchURL)?query=\(encodedMovieTitle!)"
        
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([SearchedMovie]?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue(NaverKey.naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(NaverKey.naverKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let session = URLSession.shared
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: request) { (data, response, error) in
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
    func parseJSON(_ movieData: Data) -> [SearchedMovie]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData: MovieSearchResponse = try decoder.decode(MovieSearchResponse.self, from: movieData)
            
            let searchedList: [Item] = decodedData.items
            
            let myMovielists: [SearchedMovie] = searchedList.map {
                SearchedMovie(title: $0.title, image: $0.image, director: $0.director, actor: $0.actor)
            }
            
            return myMovielists
            
        } catch {
            print("파싱 실패")
            
            return nil
        }
        
    }
    
}
