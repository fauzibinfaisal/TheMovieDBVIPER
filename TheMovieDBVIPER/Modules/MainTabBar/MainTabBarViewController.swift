//
//  MainTabBarViewController.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    var presenter: MainTabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.setupTabBarView()
    }
    
    private func setupTabBarView(){
        // create child view controllers & Configure the tab bar items with icons
        let homeIcon = UIImage(systemName: "house")
        let homeTabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        let tab1VC = MovieListRouter.setupModule()
        tab1VC.title = "Netplix"
        tab1VC.tabBarItem = homeTabBarItem
        let tab1NC = UINavigationController(rootViewController: tab1VC)
        
        let settingsIcon = UIImage(systemName: "heart")
        let settingsTabBarItem = UITabBarItem(title: "Favorite", image: settingsIcon, tag: 1)
        let tab2VC = MovieFavoriteViewController()
        tab2VC.title = "Favorite Movies"
        tab2VC.tabBarItem = settingsTabBarItem
        let tab2NC = UINavigationController(rootViewController: tab2VC)
        
        self.viewControllers = [tab1NC, tab2NC]
        tabBar.tintColor = UIColor(named: "PrimaryColor")
        extendedLayoutIncludesOpaqueBars = true
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        presenter?.didSelectTab(index: tabBarController.selectedIndex)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        presenter?.willSelectTab(index: tabBarController.selectedIndex)
        return true
    }
}
