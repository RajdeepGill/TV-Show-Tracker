//
//  show!ViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-31.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class ShowViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var show: Shows? = nil
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var networkLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet weak var summaryView: UITextView!
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var favUnFav: UIBarButtonItem!
    @IBAction func favShow(sender: AnyObject) {
        createNewShow()
    }
    
    let api = API()
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    
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
        titleLabel.text = show!.name
        if show!.scheduleDay!.isEmpty  {
            dayLabel.text = "none"
        } else {
            dayLabel.text = show!.scheduleDay![0]
        }
        timeLabel.text = show!.scheduleTime
        networkLabel.text = show!.networkName
        if show!.genres!.isEmpty {
            genresLabel.text = "none"
        } else {
            genresLabel.text = show!.genres![0]
        }
        summaryView.text = show!.summary
        if let url  = NSURL(string: show!.imageMedium!),
            imageData = NSData(contentsOfURL: url)
        {
            poster.image = UIImage(data: imageData)
        }
        if let url  = NSURL(string: show!.imageOriginal!),
            imageData = NSData(contentsOfURL: url)
        {
            background.image = UIImage(data: imageData)
        }
    }
    
    func createNewShow() {
        // Create Predicate
        let fetchRequest = NSFetchRequest(entityName: "Shows")
        let predicate = NSPredicate(format: "%K == %@", "id", show!.id!)
        fetchRequest.predicate = predicate
        // Execute Fetch Request
        do {
            let result = try self.moc.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                let deleteShow = result[0] as! NSManagedObject
                
                self.moc.deleteObject(deleteShow)
                
                do {
                    try self.moc.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                favUnFav.title = "Favourite"
                
            } else {
                let entityDescription = NSEntityDescription.entityForName("Shows", inManagedObjectContext: moc)
                let saveShow = Shows(entity: entityDescription!, insertIntoManagedObjectContext: moc)
                
                saveShow.id =               show!.id
                saveShow.url =              show!.url
                saveShow.name =             show!.name
                saveShow.type =             show!.type
                saveShow.language =         show!.language
                saveShow.genres =           show!.genres
                saveShow.status =           show!.status
                saveShow.runtime =          show!.runtime
                saveShow.premiered =        show!.premiered
                saveShow.scheduleTime =     show!.scheduleTime
                saveShow.scheduleDay =      show!.scheduleDay
                saveShow.ratingAvg =        show!.ratingAvg
                saveShow.ratingWeigt =      show!.ratingWeigt
                saveShow.networkId =        show!.networkId
                saveShow.networkName =      show!.networkName
                saveShow.countryName =      show!.countryName
                saveShow.countryCode =      show!.countryCode
                saveShow.countryTimezone =  show!.countryTimezone
                saveShow.webChannel =       show!.webChannel
                saveShow.tvrage =           show!.tvrage
                saveShow.thetvdb =          show!.thetvdb
                saveShow.imdb =             show!.imdb
                saveShow.imageMedium =      show!.imageMedium
                saveShow.imageOriginal =    show!.imageOriginal
                saveShow.summary =          show!.summary
                saveShow.lastUpdate =       show!.lastUpdate
                saveShow.href =             show!.href
                saveShow.previousEpisode =  show!.previousEpisode
                saveShow.nextEpisode =      show!.nextEpisode
                
                do {
                    try moc.save()
                } catch {
                    return
                }
                favUnFav.title = "Unfavourite"
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
