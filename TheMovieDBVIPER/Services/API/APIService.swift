//
//  APIService.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

class ApiService {
    let apiKey = Secrets.API_KEY
    let baseUrl = Const.BaseURL
    
    func getMoviesList(page: Int, count: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/now_playing?api_key=\(apiKey)&page=\(page)&page_size=\(count)")!
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data error", code: 0, userInfo: nil)))
                return
            }
            do {
                let movies = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getMoviesList(completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/now_playing?api_key=\(apiKey)")!
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data error", code: 0, userInfo: nil)))
                return
            }
            do {
                let movies = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/\(id)?api_key=\(apiKey)")!
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data error", code: 0, userInfo: nil)))
                return
            }
            do {
                let movieDetail = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
