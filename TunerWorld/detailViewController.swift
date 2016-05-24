//
//  detailViewController.swift
//  TunerWorld
//
//  Created by student1 on 5/16/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    var selectedMake = ""
    var selectedModel = ""
    var selectedYear = ""
    var makeNicename = ""
    var modelNicename = ""
    
    
    
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
        
        
        let myString = "https://api.edmunds.com/api/vehicle/v2/\(makeNicename)/\(modelNicename)/\(selectedYear)/styles?view=full&fmt=json&api_key=rduby6uckm74q7f3jy72x344"
        //print(myString)
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
                    
                    var engineCode = ""
                    var cylinderCount = ""
                    var displacement = ""
                    var configuration = ""
                    var horsepower = ""
                    var torque = ""
                    var compressionRatio = ""
                    var aspiration = ""
                    var peakPower = ""
                    var peakTorque = ""
                    var timing = ""
                    var gear = ""
                    
                    var transmissionName = ""
                    var transmissionType = ""
                    var numberOfSpeeds = ""
                    
                    var driveWheels = ""
                    var msrp = ""
                    var numberProduced = ""
                    var mpgHighway = ""
                    var mpgCity = ""
                    
                    for thing1 in self.styleJson
                    {
                        print(thing1.objectForKey("engine"))
                        //engineCode = styleJson.objectAtIndex(0).objectForKey("manufacturerEngineCode") as! String
                    }
                    
                    
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
        }
       
        task.resume()
    }
    
    
    
}