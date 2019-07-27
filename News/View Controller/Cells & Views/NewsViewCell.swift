//
//  NewsViewCell.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import UIKit
import moa

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var newsHeadlineImageView: UIImageView!
    
    @IBOutlet weak var newsTtileLabel: UILabel!
    
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     }
    
    func configure(with article : Article) {
        newsHeadlineImageView.image = UIImage(named: "placeholder.jpg")
        newsHeadlineImageView.moa.url = article.urlToImage
        newsTtileLabel.text = article.title
        newsAuthorLabel.text = article.author
        newsDescriptionLabel.text = article.descriptionField
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
