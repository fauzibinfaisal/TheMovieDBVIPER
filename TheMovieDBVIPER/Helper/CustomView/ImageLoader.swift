//
//  ImageLoader.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>, Bool) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>, Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.init(catching: {
                let imageData = try Data(contentsOf: url)
                guard let image = UIImage(data: imageData) else {
                    throw ImageLoadingError.failedToLoadImage
                }
                return image
            }), true)
        }
    }
}

enum ImageLoadingError: Error {
    case failedToLoadImage
}

extension UIImageView {
    
    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        
        guard let url = URL(string: urlString) else {
            print("image didn't found")
            return
        }
        
        if let placeholderImage = placeholder {
            self.image = placeholderImage
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let imageData = data else {
                print("No data received")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        task.resume()
    }
}

