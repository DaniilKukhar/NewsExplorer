//
//  News.swift
//  NewsExplore
//
//  Created by Danya Kukhar on 03.10.2022.
//

import SwiftUI
import Foundation

struct NewsResponse: Decodable, Hashable {
    var articles: [Article]
}

struct Article: Decodable, Hashable {
    var source: Source
    var author: String?
    var title: String
    var description: String
    var urlToImage: String?
    var publishedAt: String?
}

struct Source: Decodable, Hashable {
    var id: String?
    var name: String
}
