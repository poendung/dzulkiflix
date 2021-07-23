//
//  ViewController.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        RestApiService.getGenreList(completed: { genres in
            for genre in genres {
                RestApiService.getMovieListBy(genre: genre.id, completed: { movies in
                    
                })
            }
        })
        
        
    }
}

