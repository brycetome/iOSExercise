//
//  Recipe.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public struct Recipe: Codable, Equatable {
    var cuisine: String
    var name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var uuid: String
    var source_url: String?
    var youtube_url: String?
}
