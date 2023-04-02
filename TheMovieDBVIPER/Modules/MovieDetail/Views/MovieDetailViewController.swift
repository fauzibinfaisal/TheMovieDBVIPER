//
//  MovieDetailViewController.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import UIKit

protocol MovieDetailViewControllerInterface {
    func showMovieDetail(movie: MovieDetailEntity)
    func toggleFavorite(isFavorite: Bool)
}

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterInterface!
    var movieId: Int!
    var isFavorite = false
    var model: MovieDetailEntity?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var topRoundedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigation()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
        presenter?.getMovieDetail(id: movieId)
        presenter?.getIsFavorite(id: movieId)
    }
    
    // MARK: - Navigation
    private func setupNavigation(){
        // Set the navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Detail"
        self.setupToggleButton()
    }
    
    private func setupToggleButton(){
        let starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(toggleFavoriteIconTapped))
        navigationItem.rightBarButtonItem = starButton
    }
    
    @objc func toggleFavoriteIconTapped() {
        if let _ = navigationItem.rightBarButtonItem?.image {
            toggleFavoriteAction()
        }
    }
    
    private func toggleFavoriteAction() {
        isFavorite = !isFavorite
        toggleFavoriteIcon()
        guard let model = model else { return }
        presenter?.starTapped(movie: model, isFavorite: isFavorite)
    }
    
    private func toggleFavoriteIcon(){
        navigationItem.rightBarButtonItem?.image =
        isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    // MARK: - UI
    private func setupUI(){
        topRoundedView.layer.cornerRadius = 20
        topRoundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    
    private func updateData(model: MovieDetailEntity){
        self.model = model
        DispatchQueue.main.async {
            self.movieImage.setImage(from: model.backgroundImage)

            self.nameLabel.text = model.name
            self.releaseDateLabel.text = "Release Date : \(model.releaseDate)"
            self.descriptionLabel.attributedText = model.movieDescription.htmlAttributedString()
        }
    }
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func showMovieDetail(movie: MovieDetailEntity) {
        updateData(model: movie)
    }
    
    func toggleFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
        toggleFavoriteIcon()
    }
}
