//
//  MoviesViewController.swift
//  flicker
//
//  Created by victor aguirre on 3/8/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    var apiKeys = ("page","results")
    var apiKeysResultsKey = (poster_path:"poster_path",adult:"adult",overview:"overview",release_date:"release_date",genre_ids:"genre_ids",id:"id",original_title:"original_title",original_language:"original_language",title:"title",backdrop_path:"backdrop_path",popularity:"popularity",vote_count:"vote_count",video:"video",vote_average:"vote_average")
    
    
    var baseUrl = "http://image.tmdb.org/t/p/w500/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies =  responseDictionary["results"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let results = getResults(indexPath)
        cell.titleLabel.text = results[apiKeysResultsKey.title] as! String
        cell.overviewLabel.text = results[apiKeysResultsKey.overview] as! String
       // cell.posterImageView.set posterImageView
        cell.posterView.setImageWithURL(results["imageUrl"] as! NSURL)
        return cell
    }
    
    func getResults(indexPath: NSIndexPath) -> NSDictionary {
        let movie = movies![indexPath.row]
        let title = movie[apiKeysResultsKey.title] as! String
        let overview = movie[apiKeysResultsKey.overview] as! String
        let base = baseUrl
        let posterPath = movie[apiKeysResultsKey.poster_path] as! String
        let imageUrl = NSURL(string: base + posterPath)
        
        let result = [apiKeysResultsKey.title:title,apiKeysResultsKey.overview:overview,"imageUrl":imageUrl!]
        return result
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let results = getResults(indexPath!)
        
        let detailsViewController = segue.destinationViewController as! DetailsViewController
        detailsViewController.movies = results
        print(results)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
