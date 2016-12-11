//
//  ShowViewController.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-31.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class NewShowViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
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
    
    var segShow = Show()
    var tempEpisodes: [Episode] = []

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
        checkShow()
        
        titleLabel.text = segShow.name
        if segShow.scheduleDay!.isEmpty  {
            dayLabel.text = "none"
        } else {
            dayLabel.text = segShow.scheduleDay![0]
        }
        timeLabel.text = segShow.scheduleTime
        networkLabel.text = segShow.networkName
        if segShow.genres!.isEmpty {
            genresLabel.text = "none"
        } else {
            genresLabel.text = segShow.genres![0]
        }
        summaryView.text = segShow.summary
        if let url  = NSURL(string: segShow.imageMedium!),
            imageData = NSData(contentsOfURL: url)
        {
            poster.image = UIImage(data: imageData)
        }
        if let url  = NSURL(string: segShow.imageOriginal!),
            imageData = NSData(contentsOfURL: url)
        {
            background.image = UIImage(data: imageData)
        }
    }
    
    func checkShow() {
        let fetchRequest = NSFetchRequest(entityName: "Shows")
        
        let predicate = NSPredicate(format: "%K == %@", "id", segShow.id!)
        fetchRequest.predicate = predicate
        
        // Execute Fetch Request
        do {
            let result = try self.moc.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                favUnFav.title = "Unfavourite"
            } else {
                favUnFav.title = "Favourite"
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        
    }
    
    func createNewShow() {
        // Create Predicate
        let fetchRequest = NSFetchRequest(entityName: "Shows")
        let predicate = NSPredicate(format: "%K == %@", "id", segShow.id!)
        fetchRequest.predicate = predicate
        // Execute Fetch Request
        do {
            let result = try self.moc.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                let show = result[0] as! NSManagedObject
                
                self.moc.deleteObject(show)
                
                do {
                    try self.moc.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                favUnFav.title = "Favourite"
                
            } else {
                let entityDescription = NSEntityDescription.entityForName("Shows", inManagedObjectContext: moc)
                let show = Shows(entity: entityDescription!, insertIntoManagedObjectContext: moc)
                
                show.id =               segShow.id
                show.url =              segShow.url
                show.name =             segShow.name
                show.type =             segShow.type
                show.language =         segShow.language
                show.genres =           segShow.genres
                show.status =           segShow.status
                show.runtime =          segShow.runtime
                show.premiered =        segShow.premiered
                show.scheduleTime =     segShow.scheduleTime
                show.scheduleDay =      segShow.scheduleDay
                show.ratingAvg =        segShow.ratingAvg
                show.ratingWeigt =      segShow.ratingWeigt
                show.networkId =        segShow.networkId
                show.networkName =      segShow.networkName
                show.countryName =      segShow.countryName
                show.countryCode =      segShow.countryCode
                show.countryTimezone =  segShow.countryTimezone
                show.webChannel =       segShow.webChannel
                show.tvrage =           segShow.tvrage
                show.thetvdb =          segShow.thetvdb
                show.imdb =             segShow.imdb
                show.imageMedium =      segShow.imageMedium
                show.imageOriginal =    segShow.imageOriginal
                show.summary =          segShow.summary
                show.lastUpdate =       segShow.lastUpdate
                show.href =             segShow.href
                show.previousEpisode =  segShow.previousEpisode
                show.nextEpisode =      segShow.nextEpisode
                
                do {
                    try moc.save()
                    saveEpisodes(show)
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
    
    func saveEpisodes(show: Shows) {
        api.getEpisodes("http://api.tvmaze.com/shows/" + segShow.id! + "/episodes") {
            (episodes) in
            self.tempEpisodes = episodes
        

        for episode in self.tempEpisodes {
            
            
            
            let newEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episodes", inManagedObjectContext: self.moc) as! Episodes
            
            newEpisode.id =            episode.id
            newEpisode.url =           episode.url
            newEpisode.name =          episode.name
            newEpisode.season =        episode.season
            newEpisode.number =        episode.number
            newEpisode.airdate =       episode.airdate
            newEpisode.airtime =       episode.airtime
            newEpisode.airstamp =      episode.airstamp
            newEpisode.runtime =       episode.runtime
            newEpisode.imageMedium =   episode.imageMedium
            newEpisode.imageOriginal = episode.imageOriginal
            newEpisode.summary =       episode.summary
            newEpisode.shows =         show
            
//            show.setValue(NSSet(object: newEpisode), forKey: "Episodes")
            
            do {
                try self.moc.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }

        }
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
