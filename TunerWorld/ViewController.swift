//JUSTIN LAZARSKI
//  ViewController.swift
//  TunerWorld
//  This is cool
// This is neat.
//  Created by student1 on 5/2/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL: NSURL = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=rduby6uckm74q7f3jy72x344")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        var listOfMakes = NSArray()
//        var arrayOfMakes = [String]()
//        var arrayOfModels = [String]()
        var arrayOfCars = [Car]()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    let results = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    listOfMakes = results.objectForKey("makes") as! NSArray
                    
                    
                    var make = ""
                    var model = ""
                    var year: NSNumber!
                    
                    
                    for thing1 in listOfMakes
                    {
                        make = thing1.objectForKey("name") as! String
                        
                        for thing2 in thing1.objectForKey("models") as! NSArray
                        {
                            model = thing2.objectForKey("name") as! String
                            
                            for thing3 in thing2.objectForKey("years") as! NSArray
                            {
                                year = thing3.objectForKey("year") as! NSNumber
//                                print("Make: \(make) Model: \(model) Year: \(year)")
                                //Car(make: make, model: model, year: year)
                                arrayOfCars.append(Car(make: make, model: model, year: year))
                                
                                
                            }
                        }
                    }
                    print(arrayOfCars.count)
                    print(arrayOfCars[32].make)
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
            }
        }
        
        task.resume()
        
        
        
    }
    
    
    
}

