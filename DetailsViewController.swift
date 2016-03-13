//
//  DetailsViewController.swift
//  flicker
//
//  Created by victor aguirre on 3/9/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var languageLabel: UILabel!
    var movies: NSDictionary!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // geting the long of the scroll view
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.height)
        
        posterImageView.alpha = 0
        
        if let image = movies["imageUrl"] as? NSURL {
            UIView.beginAnimations("fade in", context: nil)
            UIView.setAnimationDuration(1)
            posterImageView.alpha = 1
            UIView.commitAnimations()
            posterImageView.setImageWithURL(image)
        }
        
        titleLabel.text = movies["title"] as! String
        titleLabel.sizeToFit()
        
        overviewLabel.text = movies["overview"] as! String
        overviewLabel.sizeToFit()
        
        var language = movies["original_language"] as! String
        languageLabel.text = language.uppercaseString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
