//
//  NewViewModel.swift
//  MVVM Test
//
//  Created by Alex Paul on 12/30/22.
//

import Foundation

class NewsViewModel {
    var articles = [Article]()
    var onArticlesChanged: (([Article]) -> Void)?

    func fetchArticles() {
        NetworkManager.shared.getJSON { news in
            guard let news = news else { return }
            self.articles = news.articles
            self.onArticlesChanged?(self.articles)
        }
        print(articles.count)
    }
    
    
}
    
    
    

