//
//  LandingPage.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import UIKit

class LandingViewController : UIViewController {
    @IBOutlet weak var GenreTableView: UITableView!
    
    var genres: [Genre] = []
    let cellIdentifier: String = "LandingMovieTableCell"
    
    override func viewDidLoad() {
        GenreTableView.dataSource = self
//        GenreTableView.register(LandingMovieTableCell.self, forCellReuseIdentifier: cellIdentifier)
        fetchData();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func fetchData() {
        RestApiService.getGenreList(completed: { genres in
            self.genres = genres
            self.GenreTableView.reloadData()
            for (index, genre) in self.genres.enumerated() {
                RestApiService.getMovieListBy(genre: genre.id, completed: { movies in
                    self.genres[index].movies = movies
                    self.GenreTableView.reloadData()
                })
            }
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let vc = segue.destination as! MovieDetailViewController
            vc.movie = sender as? Movie
        }
        
        if (segue.identifier == "showList") {
            let vc = segue.destination as! MovieListViewController
            vc.genre = sender as? Genre
        }
    }
}

extension LandingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LandingMovieTableCell
        let item = getItem(index: indexPath.row)
        cell.GenreTitle.text = item.name
        cell.id = item.id
        cell.movies = item.movies ?? []
        cell.clickViewAllHandler = { genre in
            self.performSegue(withIdentifier: "showList", sender: self.genres[indexPath.row])
        }
        cell.clickMovieHandler = { movie in
            self.performSegue(withIdentifier: "showDetail", sender: movie)
        }
        return cell
    }
    
    func getItem(index: Int) -> Genre {
        return genres[index]
    }
}
