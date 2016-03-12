//
//  MoviesViewController.swift
//  flicker
//
//  Created by victor aguirre on 3/8/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorNetworkView: UIView!
    var movies: [NSDictionary]?
    var apiKeys = ("page","results")
    var apiKeysResultsKey = (poster_path:"poster_path",
                            adult:"adult",
                            overview:"overview",
                            release_date:"release_date",
                            genre_ids:"genre_ids",
                            id:"id",
                            original_title:"original_title",
                            original_language:"original_language",
                            title:"title",
                            backdrop_path:"backdrop_path",
                            popularity:"popularity",
                            vote_count:"vote_count",
                            video:"video",
                            vote_average:"vote_average")
    
    var endPoint: String! =  String()
    //let endPoint: String! =  "now_playing"
    var baseUrl = "http://image.tmdb.org/t/p/w500/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 0.5)
        navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        netWorkRequest()
        

        
        
    }

    func netWorkRequest(){
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let serviceUrl = "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(clientId)"
        let url = NSURL(string: serviceUrl)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
       
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies =  responseDictionary["results"] as! [NSDictionary]
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            self.tableView.reloadData()
                    }
                }
                else{
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.errorNetworkView.hidden = false
                }
                
        });
        task.resume()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let serviceUrl = "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(clientId)"
        let url = NSURL(string: serviceUrl)
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
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            self.tableView.reloadData()
                    }
                }
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()	
        });
        task.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies?.count ?? 0
    }
    
    func imageFadeIn(view: UIView){
        let movieCell = view as! MovieCell
        UIView.beginAnimations("fade in", context: nil)
        UIView.setAnimationDuration(1.5)
        movieCell.posterView.alpha = 1
        UIView.commitAnimations()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        //cell.selectionStyle = .None
        let backgroundView = UIView(frame: cell.frame)
        backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.47, blue: 0.788, alpha: 0.8)
        cell.selectedBackgroundView = backgroundView
        cell.posterView.alpha = 0
        let results = getResults(indexPath)
        cell.titleLabel.text = results[apiKeysResultsKey.title] as! String
        cell.overviewLabel.text = results[apiKeysResultsKey.overview] as! String
        imageFadeIn(cell)
        cell.posterView.setImageWithURL(results["imageUrl"] as! NSURL)
        return cell
    }
    
    func getResults(indexPath: NSIndexPath) -> NSDictionary {
        let movie = movies![indexPath.row]
        let title = movie[apiKeysResultsKey.title] as! String
        let overview = movie[apiKeysResultsKey.overview] as! String
        let base = baseUrl
        
        if let posterPath = movie[apiKeysResultsKey.poster_path] as? String {
            let imageUrl = NSURL(string: base + posterPath)
            let result = [apiKeysResultsKey.title:title,apiKeysResultsKey.overview:overview,"imageUrl":imageUrl!]
            return result
        } else {
            let result = [apiKeysResultsKey.title:title,apiKeysResultsKey.overview:overview]
            return result
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell // who is sender the info
        let indexPath = tableView.indexPathForCell(cell) // get the index of the cell that send
        
        let results = getResults(indexPath!)
        
        let detailsViewController = segue.destinationViewController as! DetailsViewController // set the destination
        detailsViewController.movies = results // give the info to the var in  detailsViewController

    }
    
    override func viewWillAppear(animated: Bool) {
        switch endPoint {
        case "now_playing":
            self.navigationItem.title = "Now Playing"
        case "top_rated":
            self.navigationItem.title = "Top Rated"
        default:
            self.navigationItem.title = "Movies"
        }
    }
    

}
