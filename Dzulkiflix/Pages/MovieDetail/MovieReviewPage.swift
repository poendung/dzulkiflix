//
//  MovieReviewPage.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation
import UIKit
import Kingfisher

class MovieReviewViewController : UIViewController {
    @IBOutlet weak var TableView: UITableView!
    var movieId: Int!
    var reviews: [Review] = []
    let cellIdentifier: String = "MovieReviewTableCell"
    var page: Int = 1
    var allDataLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        if (allDataLoaded) { return; }
        RestApiService.getMovieReviewList(id: movieId, page: page, completed: { reviews in
            if (reviews.count == 0) {
                self.allDataLoaded = true
                return;
            }
            self.reviews.append(contentsOf: reviews)
            self.TableView.reloadData()
        })
    }
}

extension MovieReviewViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieReviewTableCell
        let item = reviews[indexPath.row]
        cell.TitleLabel.text = "A review by \(item.author ?? "")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        cell.DateLabel.text = "Written by \(item.author ?? "") on \(dateFormatter.string(from: item.createdAt!))"
        cell.ReviewLabel.text = item.content
        if (item.authorDetails?.avatarPath != nil) {
            let urlString = item.authorDetails!.avatarPath!.contains("gravatar.com") ? String(item.authorDetails!.avatarPath!.dropFirst()) : "https://www.themoviedb.org/t/p/w64_and_h64_face\(item.authorDetails!.avatarPath!)"
            let avatarUrl = URL(string: urlString)
            cell.AvatarImageView.kf.setImage(with: avatarUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (indexPath.row % 2 == 1) {
//            cell.contentView.backgroundColor = UIColor.systemGray6
//        } else {
//            cell.contentView.backgroundColor = UIColor.white
//        }
        if (indexPath.row == reviews.count - 1) {
            page += 1
            fetchData()
        }
    }
}
