//
//  LandingMovieTableCell.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import UIKit

class LandingMovieTableCell : UITableViewCell {
    @IBOutlet weak var GenreTitle: UILabel!
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    @IBOutlet weak var ViewListButton: UIButton!
    @IBAction func ViewListAction(_ sender: Any) {
        clickViewAllHandler(id)
    }
    
    let cellIdentifier: String = "LandingMovieCollectionCell"
    var movies: [Movie] = []
    var id: Int = 0
    var page: Int = 1
    var loaded: Bool = false
    var clickViewAllHandler: (Int)->Void = { genreId in
        print(genreId)
    }
    
    var clickMovieHandler: (Movie)->Void = { movie in
        debugPrint(movie)
    }
    
    override func layoutSubviews() {
//        if (!loaded && movies.count > 0) {
            MovieCollectionView.dataSource = self
            MovieCollectionView.delegate = self
            MovieCollectionView.reloadData()
//            loaded = true
//        }
    }
}

extension LandingMovieTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LandingMovieCollectionCell
        let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face\(movies[indexPath.row].posterPath ?? "")"
        let url = URL(string: urlString)
        cell.MovieCoverImageView.kf.setImage(with: url)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickMovieHandler(movies[indexPath.row])
    }
}
