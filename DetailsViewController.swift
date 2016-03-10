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
    
    var movies: NSDictionary!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print(movies)
        let image = movies["imageUrl"] as! NSURL
        posterImageView.setImageWithURL(image)
        titleLabel.text = movies["title"] as! String
        overviewLabel.text = movies["overview"] as! String

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.
        print("Prepare segueway")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
*/
}
