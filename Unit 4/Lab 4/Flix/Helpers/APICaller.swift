//
//  APICaller.swift
//  Flix
//

import Foundation

class API {
    func getMovies(urlString: String, completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let results = dataDictionary["results"] as! [[String:Any]]
                
                // TODO: Convert `results` into a list of movies
                //  For reference, this is what's in `results`
                //  results = [{
                //      "title": String
                //      "overview": String
                //      "poster_path": String
                //      "backdrop_path": String
                //      ...
                //  }]
                var movies = [Movie]()
                
                for movieDict in results{
                    // Poster URL
                    guard let posterPath = movieDict["poster_path"] as? String else {
                        //if posterPath is Nil
                        print("null poster Path")
                        continue
                    }
                    //if posterPath is Not Nil, i.e. correct path
                    
                    let posterBase = MovieBaseURL.Poster.rawValue
                    let posterUrl = URL(string: posterBase + (posterPath))!
                    
                    // Backdrop URL
                    guard let backdropPath = movieDict["backdrop_path"] as? String else{
                        //if backdropPath is Nil
                        print("null backdrop")
                        continue
                    }
                    //if backdropPath is Not Nil, i.e. correct path
                    
                    let backdropBase = MovieBaseURL.Backdrop.rawValue
                    let backdropURL = URL(string: backdropBase + (backdropPath))!
                    
                    let movie = Movie(
                        title: movieDict["title"] as! String,
                        overview: movieDict["overview"] as! String,
                        posterURL: posterUrl,
                        backdropURL: backdropURL
                    )
                    
                    movies.append(movie)
                }
                
                return completion(movies)
            }
        }
        task.resume()
    }
}
