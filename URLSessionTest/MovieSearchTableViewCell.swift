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
    
}
