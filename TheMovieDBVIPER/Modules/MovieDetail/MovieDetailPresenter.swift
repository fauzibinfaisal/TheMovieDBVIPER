//
//  MovieDetailPresenter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MovieDetailPresenterInterface {
    func viewDidAppear()
    func starTapped(movie: MovieDetailEntity, isFavorite: Bool)
    func getMovieDetail(id: Int)
    func getIsFavorite(id: Int)
}

class MovieDetailPresenter {
    
    var view: MovieDetailViewControllerInterface?
    let router: MovieDetailRouter?
    let interactor: MovieDetailInteractorInterface?
    
    init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouter, view: MovieDetailViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    
    func viewDidAppear() {
    }
    
    func getMovieDetail(id: Int) {
        DispatchQueue.main.async {
            self.interactor?.fetchMovieDetail(id: id)
        }
    }
    func starTapped(movie: MovieDetailEntity, isFavorite: Bool) {
        isFavorite ? self.interactor?.addFavorite(movie: movie) : self.interactor?.removeFavorite(id: movie.id)
    }
    
    func getIsFavorite(id: Int) {
//        DispatchQueue.main.async {
//            self.interactor?.fetchMovieFavorite(id: id)
//        }
    }
    
}

extension MovieDetailPresenter : MovieDetailInteractorOutputProtocol{
    func movieDetailFetchedSuccessfully(movieDetail: MovieDetailEntity) {
        view?.showMovieDetail(movie: movieDetail)
    }
    
    func movieDetailFetchingFailed(error: Error) {
        print(error.localizedDescription)
        
    }
    
    func movieFavoriteFetchedSuccessfully(isFavorite: Bool) {
        view?.toggleFavorite(isFavorite: isFavorite)
    }
    
    func movieFavoriteFetchingFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    func movieDetailAddedSuccessfully() {}
    
    func movieDetailAddingFailed(error: Error) {
        print(error.localizedDescription)

    }
    
    func movieDetailRemovedSuccessfully() {}
    
    func movieDetailRemovingFailed(error: Error) {
        print(error.localizedDescription)
    }
}
