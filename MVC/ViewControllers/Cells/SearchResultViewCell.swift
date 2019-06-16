//
//  SearchResultViewCell.swift
//  FatViewController
//
//  Created by 安井陸 on 2019/06/15.
//  Copyright © 2019 安井陸. All rights reserved.
//

import UIKit

class SearchResultViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(article: Article) {
        titleLabel.text = article.title
        textLabel.text = article.body
    }
}
