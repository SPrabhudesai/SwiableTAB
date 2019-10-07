//
//  MovieModel.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import Foundation

class MainBOElement: Codable {
    let title: String?
    let image: URL?
    let rating: Double?
    let releaseYear: Int?
    let genre: [String]?
    
    init(title: String, image: URL, rating: Double, releaseYear: Int, genre: [String]) {
        self.title = title
        self.image = image
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
}
