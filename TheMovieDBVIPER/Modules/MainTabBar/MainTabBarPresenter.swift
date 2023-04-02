//
//  MainTabBarPresenter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

protocol MainTabBarPresenterProtocol {
    func willSelectTab(index: Int)
    func didSelectTab(index: Int)
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    weak var view: MainTabBarViewController?
    var interactor: MainTabBarInteractorProtocol
    var router: MainTabBarRouterProtocol
    
    init(view: MainTabBarViewController, interactor: MainTabBarInteractorProtocol, router: MainTabBarRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func willSelectTab(index: Int) {
        // Handle any pre-selection logic here
    }
    
    func didSelectTab(index: Int) {
        // Handle any post-selection logic here
        switch index {
        case 0:
            router.showMovieListScreen()
        case 1:
            router.showFavoritesScreen()
        default:
            break
        }
    }
}

