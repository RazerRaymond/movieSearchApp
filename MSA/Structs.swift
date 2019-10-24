//
//  Structs.swift
//  MSA
//
//  Created by Mac for Rav on 10/20/19.
//  Copyright © 2019 RayZhang. All rights reserved.
//

import Foundation
struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
}
struct Trend : Decodable{
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
    let adult : Bool
    let genre_ids : [Int]
    let original_title : String
    let original_language : String
    let video : Bool
    let backdrop_path : String?
    let popularity : Double
}
