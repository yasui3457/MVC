//
//  BrowserViewController.swift
//  FatViewController
//
//  Created by 安井陸 on 2019/06/16.
//  Copyright © 2019 安井陸. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var searchModel: SearchModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeModel()
        initializeWebView()
    }
    
    func initializeModel() {
        searchModel!.delegate = self
    }
    
    func initializeWebView() {
        let request = URLRequest(url: searchModel!.url!)
        webView.load(request)
    }
}

extension BrowserViewController: SearchModelDelegate {
    func listDidChange() {}    
}

