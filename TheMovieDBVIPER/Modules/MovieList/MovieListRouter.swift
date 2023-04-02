//
//  MovieListRouter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MovieListRouterInterface {
    func navigateToMovieDetail(movieId: Int)
}

class MovieListRouter: NSObject {
    
    var presenter: MovieListPresenterInterface!
    private weak var viewController: MovieListViewController?
    
    static func setupModule() -> MovieListViewController {
        let vc = MovieListViewController()
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router, view: vc)
        vc.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
    
}

extension MovieListRouter: MovieListRouterInterface {
    func navigateToMovieDetail(movieId: Int) {
        let vc = MovieDetailRouter.setupModule()
        vc.movieId = movieId
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

