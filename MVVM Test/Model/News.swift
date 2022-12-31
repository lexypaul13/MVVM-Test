//
//  News.swift
//  MVVM Test
//
//  Created by Alex Paul on 12/29/22.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}


struct Source: Codable {
    let id: String?
    let name: String
}
