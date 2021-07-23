//
//  MovieDetailPage.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import UIKit

class MovieDetailViewController : UITabBarController {
    var movie: Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = movie?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let infoVC = viewControllers?[0] as? MovieInfoViewController
        infoVC?.movieId = movie?.id
        
        let reviewVC = viewControllers?[1] as? MovieReviewViewController
        reviewVC?.movieId = movie?.id
        
        let trailerVC = viewControllers?[2] as? MovieTrailerViewController
        trailerVC?.movieId = movie?.id
        
        viewControllers?.forEach { let _ = $0.view }
    }
}
