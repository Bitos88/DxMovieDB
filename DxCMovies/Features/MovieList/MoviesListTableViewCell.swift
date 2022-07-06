//
//  MoviesListTableViewCell.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 3/7/22.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cover.layer.cornerRadius = 10
        cover.layer.shadowRadius = 5
        cover.layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        cover.image = nil
        title.text = nil
        overview.text = nil
        voteAverage.text = nil
    }
}
