//
//  SearchTableViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-30.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var tempShows: [Show] = []
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        searchBar.delegate = self
        searchBar.sizeToFit()
        super.viewDidLoad()
        let api = API()
        api.allShows("http:api.tvmaze.com/shows") {
         (shows) in
            self.tempShows = shows
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempShows.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as UITableViewCell
        let show = self.tempShows[indexPath.row]

        cell.textLabel!.text = show.name
        cell.imageView
        if let url  = NSURL(string: show.imageMedium!),
            imageData = NSData(contentsOfURL: url)
        {
            cell.imageView!.image = UIImage(data: imageData)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.tableView.reloadData()
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let api = API()
        if searchBar.text?.characters.count > 0 {
            let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let searchTerm = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            api.queryShows("http://api.tvmaze.com/search/shows?q=" + searchTerm) {
                (shows) in
                self.tempShows = shows
                self.tableView.reloadData()
            }
        } else {
            let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let searchTerm = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            api.queryShows("http://api.tvmaze.com/search/shows?q=" + searchTerm) {
                (shows) in
                self.tempShows = shows
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewNewShowSegue" {
            if let showViewController = segue.destinationViewController as? NewShowViewController {

                let path = tableView.indexPathForSelectedRow
                showViewController.segShow = self.tempShows[(path?.row)!]
            }
        }
    }
}
