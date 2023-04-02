//
//  BannerCarouselCell.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 03/04/23.
//

import UIKit

class BannerCarouselCell: UITableViewCell {
    
    let bannerCarouselView: BannerCarouselView = {
        let view = BannerCarouselView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageUrls: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(bannerCarouselView)
        NSLayoutConstraint.activate([
            bannerCarouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bannerCarouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            bannerCarouselView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bannerCarouselView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }
    
    func setImages(fromUrls urls: [String]) {
        
        imageUrls = urls
        let imageDownloadGroup = DispatchGroup()
        var images: [UIImage] = []
        for url in urls {
            imageDownloadGroup.enter()
            guard let imageUrl = URL(string: "\(Const.baseImage500)/\(url)") else {
                imageDownloadGroup.leave()
                continue
            }
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    images.append(image)
                }
                imageDownloadGroup.leave()
            }.resume()
        }
        imageDownloadGroup.notify(queue: .main) { [weak self] in
            self?.bannerCarouselView.setImages(images)
        }
    }
}
