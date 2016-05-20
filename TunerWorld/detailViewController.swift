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
    var style = NSArray()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myString = "https://api.edmunds.com/api/vehicle/v2/\(selectedMake)/\(selectedModel)/\(selectedYear)/styles?fmt=json&api_key=rduby6uckm74q7f3jy72x344"
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
                    //self.style = results.objectForKey("styles") as! NSArray
                    //print(r)
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
        }
       
        task.resume()
    }
    
    
    
}