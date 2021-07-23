//
//  MovieListTableCell.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation
import UIKit

class MovieListTableCell : UITableViewCell {
    @IBOutlet weak var MoviePosterView: UIImageView!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    @IBOutlet weak var MovieRatingLabel: UILabel!
    @IBOutlet weak var MovieOverviewLabel: UILabel!
    @IBOutlet weak var RatingBarView: CircleProgressView!
    
}
