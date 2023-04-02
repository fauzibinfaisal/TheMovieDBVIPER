//
//  MainTabBarRouter.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation
import UIKit

protocol MainTabBarRouterProtocol {
    func showMovieListScreen()
    func showFavoritesScreen()
}

class MainTabBarRouter: MainTabBarRouterProtocol {
    
    weak var viewController: MainTabBarViewController?
    
    init(viewController: MainTabBarViewController) {
        self.viewController = viewController
    }
    
    func showMovieListScreen() {
        let homeVC = MovieListViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        viewController?.present(homeNC, animated: true, completion: nil)
    }
    
    func showFavoritesScreen() {
        let favoriteVC = MovieFavoriteViewController()
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        viewController?.present(favoriteNC, animated: true, completion: nil)
    }
}
