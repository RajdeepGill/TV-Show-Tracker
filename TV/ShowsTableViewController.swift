//
//  ShowsTableViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-30.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import UIKit
import CoreData

class ShowsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addShow: UIBarButtonItem!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showNetwork: UILabel!
    @IBOutlet weak var showDay: UILabel!
    @IBOutlet weak var showTime: UILabel!
    @IBOutlet weak var showPoster: UIImageView!
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    let api = API()
    
    func getFRC() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Shows")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
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
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let numberOfSections = frc.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfRowsInSections = frc.sections?[section].numberOfObjects
        return numberOfRowsInSections!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("show", forIndexPath: indexPath)
        
        // Configure the cell...
        
        let show = frc.objectAtIndexPath(indexPath) as! Shows
        
        cell.textLabel!.text = show.name
        cell.detailTextLabel?.text = show.networkName
        if let url  = NSURL(string: show.imageMedium!),
            imageData = NSData(contentsOfURL: url)
        {
            cell.imageView!.image = UIImage(data: imageData)
        }


        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //        if editingStyle == .Delete {
        //            // Delete the row from the data source
        //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //        } else if editingStyle == .Insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
        let managedObject: NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        moc.deleteObject(managedObject)
        
        
        do {
            try moc.save()
        }catch {
            print("Failed to save.")
            return
        }
        //        self.tableView.reloadData()
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewShowSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tabBarController = segue.destinationViewController as! UITabBarController
            let showViewController = tabBarController.viewControllers![0] as! ShowViewController
            let episodesTableViewController = tabBarController.viewControllers![1] as! EpisodesTableViewController
            
            let show: Shows = frc.objectAtIndexPath(indexPath!) as! Shows
            showViewController.show = show
            episodesTableViewController.show = show
        }
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
