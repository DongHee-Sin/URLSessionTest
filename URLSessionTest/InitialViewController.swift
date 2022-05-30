//
//  InitialViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import UIKit


class InitialViewController: UIViewController {
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func didTapBoxofficeButton(_ sender: UIButton) {
        guard let boxofficeVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") else {
            return
        }
        
        self.navigationController?.pushViewController(boxofficeVC, animated: true)
    }
    
    
    @IBAction func didTapSearchMovieButton(_ sender: UIButton) {
        guard let searchMovieVC = storyboard?.instantiateViewController(withIdentifier: "MovieSearchViewController") else {
            return
        }
        
        self.navigationController?.pushViewController(searchMovieVC, animated: true)
    }
    
}
