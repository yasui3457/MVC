//
//  SearchModel.swift
//  MVC
//
//  Created by 安井陸 on 2019/06/16.
//  Copyright © 2019 安井陸. All rights reserved.
//

import UIKit

struct Article {
    var title: String
    var body: String
    var url: String
    
    init() {
        self.title = ""
        self.body = ""
        self.url = ""
    }
}

protocol SearchModelDelegate: class {
    func listDidChange()
}

class SearchModel {
    weak var delegate: SearchModelDelegate?
    
    //QiitaのAPI
    let QIITA_API = "https://qiita.com/api/v2/items?page=1"
    //検索結果を格納する配列
    var resultArray: [Article] = [] {
        didSet {
            delegate?.listDidChange()
        }
    }
    //選択されたURLを格納
    var url: URL?
    
    func getArticle(text: String) {
        let query = "&query=tag%3A" + text
        let url: URL = URL(string: QIITA_API + query)!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                DispatchQueue.main.async() { () -> Void in
                     self.parseToArticle(json: json)
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    private func parseToArticle(json: [Any]) {
        var parseList: [Article] = []
        let datas: [[String: Any]] = json.map { (article) -> [String: Any] in
            return article as! [String: Any]
        }
        for i in 0..<datas.count {
            let data = datas[i]
            var article: Article = Article()
            article.title = data["title"] as? String ?? ""
            article.body = data["body"] as? String ?? ""
            article.url = data["url"] as? String ?? ""
            parseList.append(article)
        }
        resultArray = parseList
    }
}
