//
//  ColorViewController.swift
//  TunerWorld
//
//  Created by mobileapps on 5/18/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    var selectedYear = ""
    var makeNicename = ""
    var modelNicename = ""
    var styleJson = NSArray()
    var arrayOfColor = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNicename = makeNicename.lowercaseString
        makeNicename = makeNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
        modelNicename = modelNicename.lowercaseString
        modelNicename = modelNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
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
                        //self.arrayOfColor = (thing1.objectForKey("Colors")?.objectForKey(1)!.objectForKey("Options"))! as! NSArray
                       print(thing1.objectForKey("colors")?.objectAtIndex(1).objectForKey("options"))
                        //print(thing1.objectForKey("engine")?.objectForKey("manufacturerEngineCode"))
                        //self.engineCode = thing1.objectForKey("engine")?.objectForKey("manufacturerEngineCode") as! String
                        
                    }
                    
                    
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
        }
        
        task.resume()
    }
    
    
    
    //UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: 1.0)
    
}
