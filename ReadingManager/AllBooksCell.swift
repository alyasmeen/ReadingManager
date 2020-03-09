//
//  AllBooksCell.swift
//  ReadingManager
//
//  Created by apple on 08/01/2020.
//  Copyright © 2020 Yasz. All rights reserved.
//

import UIKit

class AllBooksCell: UITableViewCell {

    @IBOutlet weak var bookIm: UIImageView!
    @IBOutlet weak var titleLa: UILabel!
    @IBOutlet weak var currentLa: UILabel!
    @IBOutlet weak var pagesLa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
