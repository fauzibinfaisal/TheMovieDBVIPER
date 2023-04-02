//
//  MovieListPresenter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MovieListPresenterInterface {
    func viewDidAppear ()
    func rowTapped (movieId: Int)
    func getNumberOfRows () -> Int
    func getMovieItem (at index: Int) -> MovieListEntity
    func getNextMovieList (page: Int, count: Int)
    
}

class MovieListPresenter {
    
    var view: MovieListViewControllerInterface?
    let router: MovieListRouterInterface?
    let interactor: MovieListInteractorInterface?
    var movieList = [MovieListEntity]()
    
    init(interactor: MovieListInteractorInterface, router: MovieListRouterInterface, view: MovieListViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.interactor?.fetchMovieList()
        }
    }
    
    func rowTapped(movieId: Int) {
        router?.navigateToMovieDetail(movieId: movieId)
    }
    
    func getNumberOfRows() -> Int {
        return movieList.count
    }
    
    func getMovieItem(at index: Int) -> MovieListEntity {
        return movieList[index]
    }
    
    func getNextMovieList(page: Int, count: Int) {
        self.interactor?.fetchMovieList(page: page, count: count)
    }
    
}

extension MovieListPresenter : MovieListInteractorOutputProtocol{
    
    func movieListFetchedSuccessfully(movieList: [MovieListEntity]) {
        self.movieList = movieList
        view?.setupTableView()
        view?.reloadTableView()
    }
    
    func movieListFetchingFailed(error: Error) {
        print(error.localizedDescription)
        
    }
    
    func nextMovieListFetchedSuccessfully(movieList: [MovieListEntity]) {
        self.movieList.append(contentsOf: movieList)
    }
    
    func nextListFetchingFailed(error: Error) {
        print(error.localizedDescription)
    }
}
