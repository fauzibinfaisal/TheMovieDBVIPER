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
        // Handle the search button tap here
    }
    
    @objc func hamburgerMenuButtonTapped() {
        // Handle the hamburger menu button tap here
    }
}

extension MovieListViewController: MovieListViewControllerInterface {
    // MARK: - Table View
    func setupTableView() {
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.contentInset.bottom = 20
            let cell = UINib(nibName: "MovieTableViewCell", bundle: nil)
            self.tableView.register(cell, forCellReuseIdentifier: "MovieTableViewCell")
        }
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = presenter.getMovieItem(at: indexPath.row)
        cell.selectionStyle = .none
        cell.configureCell(model: movie.tranform())
        return cell
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

