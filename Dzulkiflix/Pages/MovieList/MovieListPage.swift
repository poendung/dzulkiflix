//
//  MovieList.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import UIKit
import Kingfisher

class MovieListViewController : UIViewController {
    @IBOutlet weak var TableView: UITableView!
    
    var genre: Genre?
    var movies: [Movie] = []
    var page: Int = 1
    let cellIdentifier: String = "MovieListTableCell"
    var allDataLoaded = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = genre?.name
    }
    
    override func viewDidLoad() {
        TableView.dataSource = self
        TableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        if (allDataLoaded) { return; }
        RestApiService.getMovieListBy(genre: genre!.id, page: page, completed: { movies in
            if (movies.count == 0) {
                self.allDataLoaded = true
                return;
            }
            self.movies.append(contentsOf: movies)
            self.TableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let vc = segue.destination as! MovieDetailViewController
            vc.movie = sender as? Movie
        }
    }
}

extension MovieListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieListTableCell
        let item = movies[indexPath.row]
        cell.MovieTitleLabel.text = item.title
        cell.MovieOverviewLabel.text = item.overview
        cell.MovieRatingLabel.text = String(format: "%.0f", (item.voteAverage ?? 0) * 10)
        switch item.voteAverage ?? 0 {
            case 0..<4:
                cell.RatingBarView.maskColor = UIColor.init(named: "LowRatingMask")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.strokeColor = UIColor.init(named: "LowRatingStroke")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.progress = CGFloat((item.voteAverage ?? 0) / 10)
            case 4..<7:
                cell.RatingBarView.maskColor = UIColor.init(named: "MidRatingMask")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.strokeColor = UIColor.init(named: "MidRatingStroke")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.progress = CGFloat((item.voteAverage ?? 0) / 10)
            default:
                cell.RatingBarView.maskColor = UIColor.init(named: "HighRatingMask")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.strokeColor = UIColor.init(named: "HighRatingStroke")?.cgColor ?? UIColor.clear.cgColor
                cell.RatingBarView.progress = CGFloat((item.voteAverage ?? 0) / 10)
        }
        let url = URL(string: "https://www.themoviedb.org/t/p/w220_and_h330_face\(item.posterPath ?? "")")
        cell.MoviePosterView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (indexPath.row % 2 == 1) {
//            cell.contentView.backgroundColor = UIColor.systemGray6
//        } else {
//            cell.contentView.backgroundColor = UIColor.white
//        }
        if (indexPath.row == movies.count - 1) {
            page += 1
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: movies[indexPath.row])
    }
}
