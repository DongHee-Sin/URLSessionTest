//
//  MovieTableViewCell.swift
//  URLSessionTest
//
//  Created by 신동희 on 2022/05/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // UI 연결
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(data: Movie) {
        rank.text = "\(data.rank)위"
        movieName.text = data.movieName
    }
}
