//
//  NewtorkManager.swift
//  MVVM Test
//
//  Created by Alex Paul on 12/29/22.
//

import Foundation
import UIKit
class NetworkManager{
    static let shared = NetworkManager()
    private let baseURL = "https://newsapi.org/v2/everything?q=tesla&from=2022-11-30&sortBy=publishedAt&apiKey=832a7dc044814754adc70dde879593e4"
    private init() {}
    
    func getJSON(completion: @escaping(News?) -> Void){
        guard let url = URL(string: baseURL ) else{return}
        let request =  URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to query database", error)
            }
            guard let data = data else {
                print("Data not received\(String(describing: error))")
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedJson = try decoder.decode(News.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedJson)
                }
                print(decodedJson.articles)
            }catch let error{
                print("Json failed to decode\(String(describing: error))")
                return
            }
        }.resume()
    }

}

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    func downloadImage(_ imgURL: String, placeholder: UIImage? = nil)  {
        guard let url = URL(string: imgURL) else { return  }
        if let imageToCache = imageCache.object(forKey: imgURL as NSString) {
            image = imageToCache
            return
        }
        image = placeholder
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil,
                  let imageToCache = UIImage(data: data)
            else {
                print(error ?? URLError(.badServerResponse))
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(imageToCache, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        
    }
}
