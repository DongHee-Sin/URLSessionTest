//
//  MovieSearchViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import UIKit

// image, title, director, actor

final class MovieSearchViewController: UIViewController {
    
    // movie data
    var movieList: [SearchedMovie] = []
    
    // Search Bar 연결
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // 네트워킹 메니저 생성
    let movieManager: MovieSearchDataManager = MovieSearchDataManager()
    
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // tableview delegate setting
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        // cell register
        searchResultTableView.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieSearchTableViewCell")
        
        // searchbar deleget setting
        searchBar.delegate = self
        
        searchResultTableView.rowHeight = 150
    }
    
}


// tableview delegate
extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    // cell의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    // 어떤 셀을 보여줄건지..
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTableViewCell", for: indexPath) as? MovieSearchTableViewCell else {
            return UITableViewCell()
        }
        
        if !movieList.isEmpty {
            searchResultCell.updateCell(movieList[indexPath.row])
        }
        
        return searchResultCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieInfoVC = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else {
            return
        }
        
        movieInfoVC.movieData = movieList[indexPath.row]
        self.navigationController?.pushViewController(movieInfoVC, animated: true)
    }
}




// searchbar delegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        
        movieManager.fetchMovie(searchKeyword: text) { [self] movies in
            guard let movies = movies else {return}
            
            movieList = movies
            
            DispatchQueue.main.async { [weak self] in
                self?.searchResultTableView.reloadData()
            }
        }
    }
}
