//
//  TicketTableViewCell.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit
import SDWebImage
class TicketTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenerLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var showDetailButton: UIButton!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
     }

    
    fileprivate func updateUI() {
        ratingView.layer.cornerRadius = ratingView.frame.size.width/2
        yearView.layer.cornerRadius = yearView.frame.size.width/2
        ratingView.layer.masksToBounds = true
        ratingView.layer.borderColor = UIColor.init(hexFromString: "ED8A18").cgColor
        ratingView.layer.borderWidth = 1.0
        
        yearView.layer.masksToBounds = true
        yearView.layer.borderColor = UIColor.white.cgColor
        yearView.layer.borderWidth = 1.0
    }
    
    
    func populateCell(movie:MainBOElement) {
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.rating ?? 0.0)"
        movieReleaseYearLabel.text = "\(movie.releaseYear ?? 0)"
        if let string = movie.genre?.joined(separator: " , "){
            movieGenerLabel.text = string
        }
        if let profilePic = movie.image{
            movieImage.sd_setImage(with: profilePic, placeholderImage: UIImage(named: "placeholder.png"))
        }
        
    }
    
}
