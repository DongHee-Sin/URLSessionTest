//
//  MovieSearchViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import UIKit

// image, title, director, actor

class MovieSearchViewController: UIViewController {
    
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

        // delegate setting
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        // cell register
        searchResultTableView.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieSearchTableViewCell")
        
        searchBar.delegate = self
    }
    
}


// tableview delegate
extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTableViewCell", for: indexPath) as? MovieSearchTableViewCell else {
            return UITableViewCell()
        }
        
        return searchResultCell
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
