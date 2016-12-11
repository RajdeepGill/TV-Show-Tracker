//
//  EpisodesTableViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-04-03.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EpisodesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var show: Shows?
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc: NSFetchedResultsController = NSFetchedResultsController()

    @IBOutlet weak var tableView: UITableView!
    func getFRC() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Episodes")
        let sortDescriptor = NSSortDescriptor(key: "airdate", ascending: true)
        
        let predicate = NSPredicate(format: "shows == %@", show ?? Shows())
        fetchRequest.predicate = predicate
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        frc = getFRC()
        frc.delegate = self
        
        do {
            try frc.performFetch()
        }catch {
            print("Failed to perform initial fetch.")
            return
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let episodeSet = show?.episodes {
            let episodes = Array(episodeSet) as! [Episodes]
            print(episodes.count)
            return episodes.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("episode", forIndexPath: indexPath)

        
        
        if let episodeSet = show?.episodes {
            let episodes = Array(episodeSet) as! [Episodes]
            let episode = episodes[indexPath.row]
            var showDetails = "Season "
            showDetails += String(episode.season!)
            showDetails += " Episode "
            showDetails += String(episode.number!)
            showDetails += " - "
            showDetails += episode.name!
            cell.textLabel?.text = showDetails
            if let url  = NSURL(string: episode.imageMedium!),
                imageData = NSData(contentsOfURL: url)
            {
                cell.imageView!.image = UIImage(data: imageData)
            }

        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
