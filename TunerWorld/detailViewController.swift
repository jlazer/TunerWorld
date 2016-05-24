//
//  detailViewController.swift
//  TunerWorld
//
//  Created by student1 on 5/16/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    var selectedMake = ""
    var selectedModel = ""
    var selectedYear = ""
    var makeNicename = ""
    var modelNicename = ""
    
    var engineCode = ""
    var cylinderCount = NSNumber()
    var displacement = NSNumber()
    var configuration = ""
    var horsepower = NSNumber()
    var torque = NSNumber()
    var compressionRatio = NSNumber()
    var aspiration = ""
    var peakPower = NSNumber()
    var peakTorque = NSNumber()
    var timing = ""
    var gear = ""
    
    var transmissionName = ""
    var transmissionType = ""
    var numberOfSpeeds = ""
    
    var driveWheels = ""
    var msrp = NSNumber()
    var numberProduced = NSNumber()
    var mpgHighway = NSNumber()
    var mpgCity = NSNumber()
    
    
    
    var styleJson = NSArray()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNicename = makeNicename.lowercaseString
        makeNicename = makeNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
        modelNicename = modelNicename.lowercaseString
        modelNicename = modelNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
//        print(makeNicename)
//        print(modelNicename)
//        print(selectedYear)
        makeLabel.text = selectedMake
        modelLabel.text = selectedModel
        yearLabel.text = selectedYear
        
        
        let myString = "https://api.edmunds.com/api/vehicle/v2/\(makeNicename)/\(modelNicename)/\(selectedYear)/styles?view=full&fmt=json&api_key=rduby6uckm74q7f3jy72x344"
        print(myString)
        let requestURL: NSURL = NSURL(string: myString )!
        
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if(statusCode == 200)
            {
                do{
                    let results = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    self.styleJson = results.objectForKey("styles") as! NSArray
                    //print(self.styleJson)
                    
                    
                    
                    for thing1 in self.styleJson
                    {
                        //print(thing1.objectForKey("engine")?.objectForKey("manufacturerEngineCode"))
                        //Not all cars have an engine code. how can we deal with this.
                        self.engineCode = thing1.objectForKey("engine")?.objectForKey("manufacturerEngineCode") as! String
                        self.cylinderCount = thing1.objectForKey("engine")?.objectForKey("cylinder") as! NSNumber
                        self.displacement = thing1.objectForKey("engine")?.objectForKey("displacement") as! NSNumber
                        self.configuration = thing1.objectForKey("engine")?.objectForKey("configuration") as! String
                        self.horsepower = thing1.objectForKey("engine")?.objectForKey("horsepower") as! NSNumber
                        self.torque = thing1.objectForKey("engine")?.objectForKey("torque") as! NSNumber
                        self.compressionRatio = thing1.objectForKey("engine")?.objectForKey("compressionRatio") as! NSNumber
                        self.aspiration = thing1.objectForKey("engine")?.objectForKey("compressorType") as! String
                        self.peakPower = thing1.objectForKey("engine")?.objectForKey("rpm")?.objectForKey("horsepower") as! NSNumber
                        self.peakTorque = thing1.objectForKey("engine")?.objectForKey("rpm")?.objectForKey("torque") as! NSNumber
                        self.timing = thing1.objectForKey("engine")?.objectForKey("valve")?.objectForKey("timing") as! String
                        self.gear = thing1.objectForKey("engine")?.objectForKey("valve")?.objectForKey("gear") as! String
                        
                        self.transmissionName = thing1.objectForKey("transmission")?.objectForKey("name") as! String
                        self.transmissionType = thing1.objectForKey("transmission")?.objectForKey("transmissionType") as! String
                        self.numberOfSpeeds = thing1.objectForKey("transmission")?.objectForKey("numberOfSpeeds") as! String
                        
                        self.driveWheels = thing1.objectForKey("drivenWheels") as! String
                        
                        //self.msrp = thing1.objectForKey("price")?.objectForKey("baseMsrp") as! NSNumber
                        //print(thing1.objectAtIndex(0))
                        //self.numberProduced = thing1.objectForKey("transmission")?.objectForKey("numberOfSpeeds") as! String
                        //self.mpgCity = thing1.objectForKey("MPG")?.objectForKey("city") as! String
                        //self.mpgHighway = thing1.objectForKey("MPG")?.objectForKey("highway") as! String
                       
                    }
                    
                    
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
        }
       
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nvc = segue.destinationViewController as! SpecsViewController
        nvc.selectedMake = selectedMake
        nvc.selectedModel = selectedModel
        nvc.selectedYear = selectedYear
        nvc.engineCode = engineCode
        nvc.cylinderCount = cylinderCount
        nvc.displacement = displacement
        nvc.configuration = configuration
        nvc.horsepower = horsepower
        nvc.torque = torque
        nvc.compressionRatio = compressionRatio
        nvc.aspiration = aspiration
        nvc.peakPower = peakPower
        nvc.peakTorque = peakTorque
        nvc.timing = timing
        nvc.gear = gear
        nvc.transmissionName = transmissionName
        nvc.transmissionType = transmissionType
        nvc.numberOfSpeeds = numberOfSpeeds
        nvc.driveWheels = driveWheels
        
        }

    
}