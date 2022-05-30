//
//  MovieSearchViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate setting
//        movieTableView.delegate = self
//        movieTableView.dataSource = self
        
        // cell register
//        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    
}



extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
