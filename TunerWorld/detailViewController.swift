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
    var engineSize = NSNumber()
    
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

                        
                        if let value1 = thing1.objectForKey("engine")?.objectForKey("manufacturerEngineCode") as? String
                        {
                            self.engineCode = value1
                        }
                        else
                        {
                            self.engineCode = "N/A"
                        }
                        if let value5 = thing1.objectForKey("engine")?.objectForKey("cylinder") as? NSNumber
                        {
                            self.cylinderCount = value5
                        }
                        else
                        {
                            self.cylinderCount = 0
                        }
                        
                        if let value2 = thing1.objectForKey("engine")?.objectForKey("displacement") as? NSNumber
                        {
                            self.displacement = value2
                        }
                        else
                        {
                            self.displacement = 0
                        }
                        
                        if let value7 = thing1.objectForKey("engine")?.objectForKey("configuration") as? String
                        {
                            self.configuration = value7
                        }
                        else
                        {
                            self.configuration = "N/A"
                        }
                        if let value15 = thing1.objectForKey("engine")?.objectForKey("horsepower") as? NSNumber
                        {
                            self.horsepower = value15
                        }
                        else
                        {
                            self.horsepower = 0
                        }
                        if let value16 = thing1.objectForKey("engine")?.objectForKey("torque") as? NSNumber
                        {
                            self.torque = value16
                            
                        }
                        else
                        {
                            self.torque = 0
                        }
                        if let value3 = thing1.objectForKey("engine")?.objectForKey("compressionRatio") as? NSNumber
                        {
                            self.compressionRatio = value3
                        }
                        else
                        {
                            self.compressionRatio = 0
                        }
                        if let value6 = thing1.objectForKey("engine")?.objectForKey("compressorType") as? String
                        {
                            self.aspiration = value6
                        }
                        else
                        {
                         self.aspiration = "N/A"
                        }
                        if let value8 = thing1.objectForKey("engine")?.objectForKey("rpm")?.objectForKey("horsepower") as? NSNumber
                        {
                            self.peakPower = value8
                        }
                        else
                        {
                            self.peakPower = 0
                        }
                        if let value9 = thing1.objectForKey("engine")?.objectForKey("rpm")?.objectForKey("torque") as? NSNumber
                        {
                            self.peakTorque = value9
                        }
                        else
                        {
                            self.peakTorque = 0
                        }
                        if let value3 = thing1.objectForKey("engine")?.objectForKey("valve")?.objectForKey("timing") as? String
                        {
                            self.timing = value3
                        }
                        else
                        {
                            self.timing = "N/A"
                        }
                        if let value4 = thing1.objectForKey("engine")?.objectForKey("valve")?.objectForKey("gear") as? String
                        {
                            self.gear = value4
                        }
                        else
                        {
                            self.gear = "N/A"
                        }
                        if let value10 = thing1.objectForKey("engine")?.objectForKey("size") as? NSNumber
                        {
                            self.engineSize = value10
                        }
                        else
                        {
                            self.engineSize = 0
                        }
                        if let value11 = thing1.objectForKey("transmission")?.objectForKey("name") as? String
                        {
                           self.transmissionName = value11
                        }
                        else
                        {
                         self.transmissionName = "N/A"
                        }
                        if let value12 = thing1.objectForKey("transmission")?.objectForKey("transmissionType") as? String
                        {
                            self.transmissionType = value12
                        }
                        else
                        {
                            self.transmissionType = "N/A"
                        }
                        
                        if let value13 = thing1.objectForKey("transmission")?.objectForKey("numberOfSpeeds") as? String
                        {
                            self.numberOfSpeeds = value13
                        }
                        else
                        {
                            self.numberOfSpeeds = "N/A"
                        }
                        if let value14 = thing1.objectForKey("drivenWheels") as? String
                        {
                            self.driveWheels = value14
                        }
                        else
                        {
                            self.driveWheels = "N/A"
                        }
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
        
        
        if segue.identifier == "specsSegue"
        {
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
        nvc.engineSize = engineSize
        nvc.transmissionName = transmissionName
        nvc.transmissionType = transmissionType
        nvc.numberOfSpeeds = numberOfSpeeds
        nvc.driveWheels = driveWheels
        }
        else
        {
            let nvc = segue.destinationViewController as! ColorViewController
            nvc.makeNicename = makeNicename
            nvc.modelNicename = modelNicename
            nvc.selectedYear = selectedYear
            
        }
        
        
        }

    
}