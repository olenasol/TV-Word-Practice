//
//  Movie.swift
//  TV Word Practice
//
//  Created by macbook on 18.10.2020.
//  Copyright © 2020 CS50. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let name: String
    let poster: String
    let words: [Word]
}

struct Word: Codable {
    let word: String
    let translation: String
}
