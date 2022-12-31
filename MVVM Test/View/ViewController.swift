//
//  ViewController.swift
//  MVVM Test
//
//  Created by Alex Paul on 12/29/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = NewsViewModel()
    var articles = [Article]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.onArticlesChanged = { [weak self] articles in
            self?.articles = articles
            self?.tableView.reloadData()
        }
        viewModel.fetchArticles()
        
    }
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let article = viewModel.articles[indexPath.row]
        cell.newsImage.downloadImage(article.urlToImage ?? "")
        cell.titeLabel.text = article.author
        cell.descriptionTitle.text = article.description
        return cell
    }
    
    
}
