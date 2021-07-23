//
//  MovieTrailerPage.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class MovieTrailerViewController : UIViewController {
    @IBOutlet weak var PlayerView: YTPlayerView!
    
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        RestApiService.getMovieVideoList(id: movieId, completed: { videos in
            let video = videos.filter { video in video.type == "Trailer" && video.site == "YouTube" }.first
            if (video != nil) {
                self.PlayerView.load(withVideoId: video!.key! )
            }
        })
    }
}
