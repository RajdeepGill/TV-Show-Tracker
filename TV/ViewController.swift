//
//  ViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-12.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, NSURLSessionDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //    @IBOutlet weak var tableCells: UITableViewCell!
    var shows: [Show] = []
    var searchResults: [Show] = []
    let DATUMBOX_API_KEY = "190f48dd9c082679cd63d38f540717f0"
    let DATUM_TEXT = ""
    let DATUMBOX_URL = "http://api.datumbox.com/GameOfThrones/TwitterSentimentAnalysis.json"
    let SEARCH_METHOD:String = "POST"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()
    
    lazy var downloadsSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("bgSessionConfiguration")
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        searchBar.barStyle = UIBarStyle.BlackTranslucent
        //        searchBar.searchBarStyle = UISearchBarStyle.Minimal
        //        searchBar.translucent = true
        //        searchBar.delegate = self
        
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Handling Search Results
    
    // This helper method helps parse response JSON NSData into an array of Track objects.
    func updateSearchResults(data: NSData?) {
        searchResults.removeAll()
        let swiftyJSON = JSON(data: data!)
//        let shows = swiftyJSON[0]["show"]
        for (var i = 0; i < swiftyJSON.count; i += 1) {
//            let name = swiftyJSON[i]["name"].stringValue
            let name = swiftyJSON[i]["show"]["name"].stringValue
            print(name)
//            searchResults.append(Show(name: name))
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPointZero, animated: false)
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dismissKeyboard()
        
        if !searchBar.text!.isEmpty {
            // 1
            if dataTask != nil {
                dataTask?.cancel()
            }
            // 2
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            // 3
            let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let searchTerm = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            // 4
            let url = NSURL(string: "http://api.tvmaze.com/search/shows?q=\(searchTerm)")
            // 5
            dataTask = defaultSession.dataTaskWithURL(url!) {
                data, response, error in
                // 6
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                // 7
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.updateSearchResults(data)
                    }
                }
            }
            // 8
            dataTask?.resume()
        }
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
    
    func getJSONArrayFromData(data:NSData) -> NSArray{
        return (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)) as! NSArray
    }
    
    // MARK: Keyboard dismissal
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath)

        // Delegate cell button tap events to this view controller
        
        let show = searchResults[indexPath.row]
        
        // Configure title and artist labels
        cell.textLabel?.text = show.name
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 62.0
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let show = searchResults[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
    //    func getShowsFromSearchString(searchString: String, callback: (shows: [Show]) -> ()){
    //        let encoded = searchString.lowercaseString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    //        let url = NSURL(string: "http://api.tvmaze.com/search/shows?q=\(encoded!)")
    //        print("http://api.tvmaze.com/search/shows?q=\(encoded!)")
    //        let request: NSURLRequest = NSURLRequest(URL: url!)
    //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    //        let session = NSURLSession(configuration: config)
    //        let task = session.dataTaskWithRequest(request, completionHandler:{ (data, response, error) in
    //            //            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
    //            //
    //            //                print(NSString(data: data, encoding: NSUTF8StringEncoding))
    //            //            }
    //            self.dataStore = data!
    //            let jsonError: NSError?
    //
    //            //            task.resume()
    //
    //            let results = NSString(data: self.dataStore, encoding: NSUTF8StringEncoding)
    //
    //
    //            do {
    //                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
    //                if let showName = (((json as? NSArray)?[0] as? NSDictionary)?["show"] as? NSDictionary)?["name"]{
    //                    //What A disaster above
    //                    print(showName)
    //                }
    //            } catch {
    //                print("error serializing JSON: \(error)")
    //            }
    //
    //            //            print(" the xml file content is ")
    //            //            print(results!)
    //            //            print(response!)
    //            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    //            //            self.parseXML()
    //        })
    //        task.resume()
    //    }
    
    
}