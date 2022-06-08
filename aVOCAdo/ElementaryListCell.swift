//
//  ElementaryListCell.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/06/06.
//

import UIKit

class ElementaryListCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
     
     초중등 영단어 리스트 나타내기
     */
}
