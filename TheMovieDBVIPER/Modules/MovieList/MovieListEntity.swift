//
//  MovieListEntity.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation

struct MovieListEntity {
    let id: Int
    let backgroundImage: String?
    let name: String
    let released: String?
}

extension MovieListEntity {
    func tranform() -> MovieCellModel {
        return MovieCellModel(
            id: self.id,
            backgroundImage: self.backgroundImage ?? "",
            name: self.name ,
            releaseDate: self.released ?? "-")
    }
}
