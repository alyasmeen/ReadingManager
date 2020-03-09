//
//  TodaysBooksCell.swift
//  ReadingManager
//
//  Created by apple on 13/01/2020.
//  Copyright © 2020 Yasz. All rights reserved.
//

import UIKit

class TodaysBooksCell: UITableViewCell {

    @IBOutlet weak var titleLa: UILabel!
    @IBOutlet weak var currentLa: UILabel!
    @IBOutlet weak var bookIm: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
