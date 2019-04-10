//
//  ArticleCell.swift
//  WIRED
//
//  Created by Özgü Ataseven on 21.04.2018.
//  Copyright © 2018 Özgü Ataseven. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
