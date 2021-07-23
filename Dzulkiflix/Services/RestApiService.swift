//
//  RestApiService.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import Alamofire

class RestApiService {
    static var ApiUrl: String = "https://api.themoviedb.org/3"
    static var ApiKey: String = "82a4e1bb498ab3320486b415eba7dbae";
    
    static func getGenreList(completed: (([Genre])->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US"
        ]
        AF.request("\(ApiUrl)/genre/movie/list", parameters: params, encoding: URLEncoding.default).responseDecodable (of: GenreResponse.self) { response in
            let result = response.result;
            switch result {
            case let .success(data):
                completed?(data.genres)
            case let .failure(err):
                print(err)
                completed?([])
            }
        }
    }
    
    static func getMovieListBy(genre: Int, page: Int = 1, completed: (([Movie])->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US",
            "sort_by": "popularity.desc",
            "include_adult": false,
            "include_video": false,
            "page": page,
            "with_genres": genre
        ]
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({(decoder)->Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            return Date.distantPast
        })

        AF.request("\(ApiUrl)/discover/movie", parameters: params, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable (of: DiscoverResponse.self, decoder: decoder) { response in
                let result = response.result;
                switch result {
                case let .success(data):
                    completed?(data.results)
                case let .failure(err):
                    print(err)
                    completed?([])
                }
        }
    }
    
    static func getMovieDetail(id:Int, completed: ((Movie?)->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US"
        ]
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({(decoder)->Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            return Date.distantPast
        })
        
        AF.request("\(ApiUrl)/movie/\(id)", parameters: params, encoding: URLEncoding.default).responseDecodable (of: Movie.self, decoder: decoder) { response in
            let result = response.result;
            switch result {
            case let .success(data):
                completed?(data)
            case let .failure(err):
                print(err)
                completed?(nil)
            }
        }
    }
    
    static func getMovieReviewList(id:Int, page:Int = 1, completed: (([Review])->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US",
            "page": page
        ]
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({(decoder)->Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            return Date.distantPast
        })
        
        AF.request("\(ApiUrl)/movie/\(id)/reviews", parameters: params, encoding: URLEncoding.default).responseDecodable (of: ReviewResponse.self, decoder: decoder) { response in
            let result = response.result;
            switch result {
            case let .success(data):
                completed?(data.results ?? [])
            case let .failure(err):
                print(err)
                completed?([])
            }
        }
    }
    
    static func getMovieVideoList(id:Int, completed: (([Video])->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US"
        ]
        AF.request("\(ApiUrl)/movie/\(id)/videos", parameters: params, encoding: URLEncoding.default).responseDecodable (of: VideoResponse.self) { response in
            let result = response.result;
            switch result {
            case let .success(data):
                completed?(data.results ?? [])
            case let .failure(err):
                print(err)
                completed?([])
            }
        }
    }
    
    static func getCast(id:Int, completed: (([Cast])->())?) {
        let params: Parameters = [
            "api_key": ApiKey,
            "language": "en-US"
        ]
        AF.request("\(ApiUrl)/movie/\(id)/credits", parameters: params, encoding: URLEncoding.default).responseDecodable (of: CreditsResponse.self) { response in
            let result = response.result;
            switch result {
            case let .success(data):
                completed?(data.cast ?? [])
            case let .failure(err):
                print(err)
                completed?([])
            }
        }
    }
}
