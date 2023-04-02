//
//  MovieTableViewCell.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        photoImage.layer.cornerRadius = 8
        photoImage.layer.masksToBounds = true
    }
    
    func configureCell(model: MovieCellModel){
        titleLabel.text = model.name
        subtitleLabel.text = model.releaseDate
        photoImage.setImage(from: model.backgroundImage)
                
    }
}
