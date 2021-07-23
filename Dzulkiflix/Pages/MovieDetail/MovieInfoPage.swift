//
//  MovieInfoPage.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation
import UIKit
import Kingfisher

class MovieInfoViewController : UIViewController {
    @IBOutlet weak var CoverImageView: UIImageView!
    @IBOutlet weak var PosterImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ReleaseYearLabel: UILabel!
    @IBOutlet weak var ReleaseDateLabel: UILabel!
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var DurationLabel: UILabel!
    @IBOutlet weak var TaglineLabel: UILabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var CastLabel: UILabel!
    
    var movieId: Int!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PosterImageView.layer.cornerRadius = 6
        CoverImageView.layer.shadowColor = UIColor.black.cgColor
        CoverImageView.layer.shadowRadius = 4
        CoverImageView.layer.shadowOffset = .zero
        CoverImageView.layer.shadowOpacity = 1
        
        fetchData()
    }
    
    func fetchData() {
        RestApiService.getMovieDetail(id: movieId, completed: { movie in
            self.updateData(movie: movie ?? Movie())
        })
        
        RestApiService.getCast(id: movieId, completed: { casts in
            let castList = casts.filter{ c in c.department == "Acting" }.map{ cast in "• \(cast.name ?? "") (\(cast.character ?? ""))" }.joined(separator: "\n")
            self.CastLabel.text = castList
        })
    }
    
    func updateData(movie: Movie) {
        let posterUrl = URL(string: "https://www.themoviedb.org/t/p/w220_and_h330_face\(movie.posterPath ?? "")")
        PosterImageView.kf.setImage(with: posterUrl)
        let coverUrl = URL(string: "https://www.themoviedb.org/t/p/w1920_and_h800_multi_faces\(movie.backdropPath ?? "")")
        CoverImageView.kf.setImage(with: coverUrl)
        TitleLabel.text = movie.title
        GenreLabel.text = (movie.genres ?? []).map{$0.name!}.joined(separator: ", ")
        TaglineLabel.text = movie.tagline
        OverviewLabel.text = movie.overview
        let (h,m) = self.getTime(minute: movie.runtime ?? 0)
        DurationLabel.text = "\(h)h \(m)m"
        
        if (movie.releaseDate != nil && movie.releaseDate != Date.distantPast) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            ReleaseDateLabel.text = dateFormatter.string(from: movie.releaseDate!)
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "'('yyyy')'"
            ReleaseYearLabel.text = yearFormatter.string(from: movie.releaseDate!)
        }
    }
    
    func getTime (minute : Int) -> (Int, Int) {
        return (minute / 60, minute % 60)
    }
}
