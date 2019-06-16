//
//  SearchViewController.swift
//  FatViewController
//
//  Created by 安井陸 on 2019/06/15.
//  Copyright © 2019 安井陸. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultView: UICollectionView!
    
    let searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeModel()
        initializeSearchBar()
        initializeCollectionView()
    }
    
    func initializeModel() {
        searchModel.delegate = self
    }
    
    func initializeSearchBar() {
        searchBar.delegate = self
    }
    
    func initializeCollectionView() {
        searchResultView.register(UINib(nibName: "SearchResultViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchResultViewCell")
        searchResultView.delegate = self
        searchResultView.dataSource = self
    }
    
    func moveToBrowserViewController() {
        performSegue(withIdentifier: "ToBrowser", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBrowser" {
            guard let bvc:BrowserViewController = segue.destination as? BrowserViewController else { return }
            bvc.searchModel = searchModel
        }
    }
}

extension SearchViewController: SearchModelDelegate {
    func listDidChange() {
        searchResultView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchModel.getArticle(text: searchBar.text!)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchModel.resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultView.dequeueReusableCell(withReuseIdentifier: "SearchResultViewCell", for: indexPath) as? SearchResultViewCell else { return UICollectionViewCell() }
        cell.setCellData(article: searchModel.resultArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        searchModel.url = URL(string: searchModel.resultArray[indexPath.row].url)!
        moveToBrowserViewController()
    }
}
