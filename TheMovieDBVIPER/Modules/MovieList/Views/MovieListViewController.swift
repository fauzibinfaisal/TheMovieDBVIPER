//
//  MovieListViewController.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import UIKit

protocol MovieListViewControllerInterface {
    func setupTableView()
    func reloadTableView()
}

class MovieListViewController: UIViewController {
    
    var presenter: MovieListPresenterInterface!
    var currentPage = 1
    let countPerPage = 20
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    // MARK: - Navigation
    private func setupNavigation(){
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem = searchButton
        
        let hamburgerMenuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(hamburgerMenuButtonTapped))
        self.navigationItem.leftBarButtonItem = hamburgerMenuButton
    }
    
    @objc func searchButtonTapped() {
        // TODO: Handle the search button tap here
    }
    
    @objc func hamburgerMenuButtonTapped() {
        // TODO: Handle the hamburger menu button tap here
    }
}

extension MovieListViewController: MovieListViewControllerInterface {
    // MARK: - Table View
    func setupTableView() {
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.contentInset.bottom = 20
            let movieTableViewCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
            self.tableView.register(movieTableViewCell, forCellReuseIdentifier: "MovieTableViewCell")
            self.tableView.register(BannerCarouselCell.self, forCellReuseIdentifier: "BannerCarouselCell")

        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return presenter.getNumberOfRows()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Latest"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if indexPath.section == 0 {
               return 350
           } else {
               return UITableView.automaticDimension
           }
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCarouselCell", for: indexPath) as! BannerCarouselCell
            var movieImages = presenter.getMovieImages()
            let range = 3...movieImages.count-1
            movieImages.removeSubrange(range)
            cell.setImages(fromUrls: movieImages)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
            
            let movie = presenter.getMovieItem(at: indexPath.row)
            cell.selectionStyle = .none
            cell.configureCell(model: movie.tranform())
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter.getMovieItem(at: indexPath.row)
        presenter.rowTapped(movieId: movie.id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            currentPage += 1
            presenter.getNextMovieList(page: currentPage, count: countPerPage)
        }
    }
}

