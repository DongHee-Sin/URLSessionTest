//
//  MovieSearchTableViewCell.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/30.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    // UI 연결
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(_ movieInfo: SearchedMovie) {
        if let url = URL(string: movieInfo.image) {
            do {
                let data = try Data(contentsOf: url)
                moviePoster.image = UIImage(data: data)
            }catch {
                print("이미지 불러오기 실패")
            }
        }
    
        title.text = movieInfo.title
        director.text = movieInfo.director
        actor.text = movieInfo.actor
    }
}
