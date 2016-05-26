//
//  ColorViewController.swift
//  TunerWorld
//
//  Created by mobileapps on 5/18/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var colorTableView: UITableView!
    @IBOutlet weak var colorView: UIView!
    
    var selectedYear = ""
    var makeNicename = ""
    var modelNicename = ""
    var styleJson = NSArray()
    var arrayOfColor = NSArray()
    var arrayOfNames = [String]()
    var arrayOfBlue = [Int]()
    var arrayOfGreen = [Int]()
    var arrayOfRed = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNicename = makeNicename.lowercaseString
        makeNicename = makeNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
        modelNicename = modelNicename.lowercaseString
        modelNicename = modelNicename.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
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
                    
                    //print(self.styleJson)
                    
                    for item in self.styleJson
                    {
                        //print(item)
                        let color = item.objectForKey("colors")?.objectAtIndex(1) as! NSDictionary
                        for extColor in color.objectForKey("options") as! NSArray
                        {
                            self.arrayOfNames.append(extColor.objectForKey("name") as! String)
                            
                            for rgbValues in extColor.objectForKey("colorChips") as! NSDictionary
                            {
                                self.arrayOfBlue.append(rgbValues.value.objectForKey("b") as! Int)
                                self.arrayOfRed.append(rgbValues.value.objectForKey("r") as! Int)
                                self.arrayOfGreen.append(rgbValues.value.objectForKey("g") as! Int)
                                
                            }
                        }
                        
                    }
                    self.colorTableView.reloadData()
                    
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
        }
        
        task.resume()
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")
        cell?.textLabel?.text = arrayOfNames[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        colorView.backgroundColor = UIColor(red: CGFloat(arrayOfRed[indexPath.row])/255, green: CGFloat(arrayOfGreen[indexPath.row])/255, blue: CGFloat(arrayOfBlue[indexPath.row])/255, alpha: 1.0)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNames.count
        
    }
    
}