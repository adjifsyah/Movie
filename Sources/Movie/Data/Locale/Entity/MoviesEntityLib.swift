//
//  MoviesEntityLib.swift
//  Movie
//
//  Created by Apple Josal on 12/04/25.
//

import RealmSwift
import Foundation

public class MoviesEntityLib: Object {
    @objc dynamic var movie_id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var average: Double = 0.0
    @objc dynamic var release_date: String = ""
    @objc dynamic var poster_path: String = ""
    @objc dynamic var backdrop_path: String = ""
    
    public override static func primaryKey() -> String? {
        return "movie_id"
    }
}
