//
//  MovieInfoViewController.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/06/03.
//

import UIKit

final class MovieInfoViewController: UIViewController {
    
    // 영화 정보
    var movieData: SearchedMovie?
    
    // UI 연결
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = movieData {
            updateView(data)
        }
        
        self.title = nil
    }
    
    
    func updateView(_ data: SearchedMovie) {
        if let url = URL(string: data.image) {
            do {
                let data = try Data(contentsOf: url)
                movieImage.image = UIImage(data: data)
            }catch {
                print("이미지 불러오기 실패")
            }
        }
        
        let tagRemovedTitle: String = data.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        movieTitle.text = tagRemovedTitle
        director.text = data.director
        actor.text = data.actor
    }
}
