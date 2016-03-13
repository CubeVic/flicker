 //
//  MovieCell.swift
//  flicker
//
//  Created by victor aguirre on 3/8/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import AFNetworking

class MovieCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    var colorBlack: UIColor = UIColor.blackColor()
    var colorWhite: UIColor = UIColor.whiteColor()
    var colorPrincipal: UIColor = UIColor(hexString: "#3F51B5")!
    var colorSecundary: UIColor = UIColor(hexString: "#E3F2FD")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
