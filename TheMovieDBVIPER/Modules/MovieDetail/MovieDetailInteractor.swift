//
//  MovieDetailInteractor.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MovieDetailInteractorInterface {
    func fetchMovieDetail(id: Int)
//    func fetchMovieFavorite(id: Int)
    func addFavorite(movie: MovieDetailEntity)
    func removeFavorite(id: Int)
}

protocol MovieDetailInteractorOutputProtocol {
    func movieDetailFetchedSuccessfully(movieDetail: MovieDetailEntity)
    func movieDetailFetchingFailed(error: Error)
    func movieFavoriteFetchedSuccessfully(isFavorite: Bool)
    func movieFavoriteFetchingFailed(error: Error)
    func movieDetailAddedSuccessfully()
    func movieDetailAddingFailed(error: Error)
    func movieDetailRemovedSuccessfully()
    func movieDetailRemovingFailed(error: Error)
}

final class MovieDetailInteractor {
    var output: MovieDetailInteractorOutputProtocol?
    var apiService: ApiService = ApiService()
//    var coreDataManager: CoreDataManager = CoreDataManager.shared
    
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
//    func fetchMovieFavorite(id: Int) {
//        let result = coreDataManager.getMovieObjectById(id: Int16(id))
//        switch result {
//        case .success(let movieObject):
//            if let _ = movieObject {
//                self.output?.movieFavoriteFetchedSuccessfully(isFavorite: true)
//            } else {
//                self.output?.movieFavoriteFetchedSuccessfully(isFavorite: false)
//            }
//        case .failure(let error):
//            print("Error adding movie object: \(error)")
//            self.output?.movieDetailAddingFailed(error: error)
//        }
//    }
    

    func fetchMovieDetail(id: Int) {
        apiService.getMovieDetail(id: id) { [weak self] result in
            switch result {
            case .success(let response):
                let movieDetail = MovieDetailEntity(
                    id: response.id,
                    backgroundImage: "\(Const.baseImage)/\(response.posterPath ?? "-")",
                    name: response.title,
                    movieDescription: response.overview, releaseDate: response.releaseDate ?? "-")
                self?.output?.movieDetailFetchedSuccessfully(movieDetail: movieDetail)
            case .failure(let error):
                self?.output?.movieDetailFetchingFailed(error: error)
            }
        }
    }
    
    func addFavorite(movie: MovieDetailEntity) {
//        let result = coreDataManager.addMovieObject(data: movie)
//        switch result {
//        case .success(let movieObject):
//            print("Successfully added movie object: \(movieObject)")
//            self.output?.movieDetailAddedSuccessfully()
//        case .failure(let error):
//            print("Error adding movie object: \(error)")
//            self.output?.movieDetailAddingFailed(error: error)
//        }
    }
    
    func removeFavorite(id: Int) {
//        let result = coreDataManager.removeMovieObject(id: id)
//        switch result {
//        case .success:
//            print("Successfully remove movie object \(id)")
//            self.output?.movieDetailAddedSuccessfully()
//        case .failure(let error):
//            print("Error adding movie object: \(error)")
//            self.output?.movieDetailAddingFailed(error: error)
//        }
    }
}
