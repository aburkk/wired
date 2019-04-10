//
//  ViewController.swift
//  WIRED
//
//  Created by Özgü Ataseven on 21.04.2018.
//  Copyright © 2018 Özgü Ataseven. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles()
        
        
        
        view.addSubview(tableView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=wired&apiKey=11f97f4395b2424186c2e213b57d3f7d")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            var counter: Int = 0
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    
                    for articleFromJson in articlesFromJson {
                        if counter<5 {
                            
                            let article = Article()
                            if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String , let date = articleFromJson["publishedAt"] as? String, let content = articleFromJson["content"] as? String{
                                
                                article.author = author
                                article.desc = desc
                                article.headline = title
                                article.url = url
                                print(url)
                                article.imageUrl = urlToImage
                                article.date = date
                                article.content = content
                            }
                            self.articles?.append(article)
                            counter = counter + 1
                        }
                    }
                    
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.articles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.articleImage.downloadImage(from: (self.articles?[indexPath.item].imageUrl)!)
        cell.author.text = self.articles?[indexPath.item].author

        let str = self.articles?[indexPath.item].date
        let separated = str?.characters.split(separator: "T")
        
        if let some = separated?.first {
            let value = String(some)
            cell.date.text = value
        }
        
        
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        print(self.articles![indexPath.item].url)
       // webVC.url = (self.articles![indexPath.item].url!)
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    
}

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

