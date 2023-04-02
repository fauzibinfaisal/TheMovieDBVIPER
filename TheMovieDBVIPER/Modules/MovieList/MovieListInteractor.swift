//
//  MovieListInteractor.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MovieListInteractorInterface {
    func fetchMovieList()
    func fetchMovieList(page: Int, count: Int)
}

protocol MovieListInteractorOutputProtocol {
    func movieListFetchedSuccessfully(movieList: [MovieListEntity])
    func movieListFetchingFailed(error: Error)
    func nextMovieListFetchedSuccessfully(movieList: [MovieListEntity])
    func nextListFetchingFailed(error: Error)

}

final class MovieListInteractor {
    var output: MovieListInteractorOutputProtocol?
    var apiService: ApiService = ApiService()
    
}

extension MovieListInteractor: MovieListInteractorInterface {

    func fetchMovieList() {
        apiService.getMoviesList() { [weak self] result in
            switch result {
            case .success(let response):
                let movieList = response.results.map {
                    MovieListEntity(
                        id: $0.id,
                        backgroundImage: "\(Const.baseImage92)/\($0.posterPath ?? "-")",
                        name: $0.title,
                        released: $0.releaseDate)}
                
                self?.output?.movieListFetchedSuccessfully(movieList: movieList)
            case .failure(let error):
                self?.output?.movieListFetchingFailed(error: error)
            }
        }
    }
    
    func fetchMovieList(page: Int, count: Int) {
        apiService.getMoviesList(page: page, count: count) { [weak self] result in
            switch result {
            case .success(let response):
                let movieList = response.results.map {
                    MovieListEntity(
                        id: $0.id,
                        backgroundImage: "\(Const.baseImage92)/\($0.posterPath ?? "-")",
                        name: $0.title,
                        released: $0.releaseDate)}
                
                self?.output?.nextMovieListFetchedSuccessfully(movieList: movieList)
            case .failure(let error):
                self?.output?.nextListFetchingFailed(error: error)
            }
        }
    }
}
