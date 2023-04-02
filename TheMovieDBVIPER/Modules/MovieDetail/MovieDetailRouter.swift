//
//  MovieDetailRouter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

class MovieDetailRouter: NSObject {
    
    var presenter: MovieDetailPresenterInterface!
    private weak var viewController: MovieDetailViewController?
    
    static func setupModule() -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)
        vc.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        return vc
    }
}
