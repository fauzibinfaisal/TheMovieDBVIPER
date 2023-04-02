//
//  MovieFavoriteViewController.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import UIKit

class MovieFavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigation()
    }

    // MARK: - Navigation
    private func setupNavigation(){
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem = searchButton
        
        let hamburgerMenuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(hamburgerMenuButtonTapped))
        self.navigationItem.leftBarButtonItem = hamburgerMenuButton
    }
    
    @objc func searchButtonTapped() {
        // Handle the search button tap here
    }
    
    @objc func hamburgerMenuButtonTapped() {
        // Handle the hamburger menu button tap here
    }

}
