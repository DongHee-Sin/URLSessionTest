//
//  ViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/20.
//

import UIKit

final class ViewController: UIViewController {
    
    // 하루 전 날자 String으로 변환
    let date = Date().dayBefore
    let dateFormatter = DateFormatter()

    
    // movie data
    var movieList: [Movie] = []
    
    
    // 네트워킹 메니저 생성
    let movieManager: MovieDataManager = MovieDataManager()
    
    
    // MARK: - UI 연결
    @IBOutlet weak var movieTableView: UITableView!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate setting
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        // cell, header register
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        movieTableView.register(UINib(nibName: "MovieTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MovieTableViewHeader")
        
        // date format setting
        dateFormatter.dateFormat = "YYYYMMdd"
        
        // 네트워킹
        movieManager.fetchMovie(date: dateFormatter.string(from: date)) { (movies) in
            guard let movies = movies else { return }
            
            self.movieList = movies
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
    }


}


// MARK: - TableView Protocol 채택
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        if !movieList.isEmpty {
            movieCell.updateCell(data: movieList[indexPath.row])
        }
        
        return movieCell
    }
    
    
    
    // 테이블뷰 Header 설정
    // Header에 사용할 view  return
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieTableViewHeader") as? MovieTableViewHeader else {
            return UIView()
        }
        return headerView
    }
    // header 높이값 주기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width / 6
    }
}
