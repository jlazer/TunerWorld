//JUSTIN LAZARSKI
//  ViewController.swift
//  TunerWorld
//  This is cool
// This is neat.
//  Created by student1 on 5/2/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var arrayOfCars = [Car]()
    var arrayOfMakes = [String]()
    var arrayOfModels = [String]()
    var tableViewLoadNumber = 0
    var arrayOfModelYears:[String] = [String]()
    var moveToNextViewController = false
    var selectedMake = String()
    var selectedModel = String()
    var selectedYear = String()
    
    @IBOutlet weak var makeTableView: UITableView!
    @IBOutlet weak var tableViewBackButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let requestURL: NSURL = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=rduby6uckm74q7f3jy72x344")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        var listOfMakes = NSArray()
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
                        self.arrayOfMakes.append(make)
                        
                        for thing2 in thing1.objectForKey("models") as! NSArray
                        {
                            model = thing2.objectForKey("name") as! String
                            
                            for thing3 in thing2.objectForKey("years") as! NSArray
                            {
                                year = thing3.objectForKey("year") as! NSNumber
                                //print("Make: \(make) Model: \(model) Year: \(year)")
                                //Car(make: make, model: model, year: year)
                                self.arrayOfCars.append(Car(make: make, model: model, year: year))
                                
                                
                            }
                        }
                    }
                    
                    
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
            }
            self.makeTableView.reloadData()
            //            print(self.returnArrayOfModels("Acura"))
            //            print(self.returnArrayOfModelYears("CL"))
        }
        
        task.resume()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableViewLoadNumber = 0
        makeTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")!
        if tableViewLoadNumber == 0
        {
            cell.textLabel?.text = arrayOfMakes[indexPath.row]
            
        }
        else if tableViewLoadNumber == 1
        {
            cell.textLabel?.text = arrayOfModels[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = arrayOfModelYears[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewLoadNumber == 0
        {
            return arrayOfMakes.count
            
        }
        else if tableViewLoadNumber == 1
        {
            return arrayOfModels.count
        }
        else
        {
            return arrayOfModelYears.count
        }
        
        
    }
    
    func returnArrayOfModels(make: String) -> [String]
    {
        var arrayOfModels:[String] = [String]()
        
        for car in arrayOfCars
        {
            if car.make == make
            {
                let currentModel = car.model
                if !(arrayOfModels.contains(currentModel))
                {
                    arrayOfModels.append(car.model)
                }
            }
        }
        return arrayOfModels
    }
    
    func returnArrayOfModelYears(model: String) -> [String]
    {
        for car in arrayOfCars
        {
            if car.model == model
            {
                self.arrayOfModelYears.append(car.year.stringValue)
                
                //print(car.year.stringValue)
            }
        }
        return self.arrayOfModelYears
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableViewLoadNumber += 1
        
        //self.selectedMake = makeTableView.indexPathForSelectedRow
        //print(selectedMake)
        //print(makeTableView.indexPathForSelectedRow!)
        print(indexPath.row)
        //selectedMake = arrayOfMakes(indexPath.row)
        print(arrayOfMakes[indexPath.row])
        
        if tableViewLoadNumber == 1
        {
            arrayOfModels = returnArrayOfModels(arrayOfMakes[indexPath.row])
            tableView.reloadData()
        }
        else if tableViewLoadNumber == 2
        {
            arrayOfModelYears = returnArrayOfModelYears(arrayOfModels[indexPath.row])
            tableView.reloadData()
            
        }
        else
        {
            performSegueWithIdentifier("selectedCar", sender: nil)
        }
        
        //print(tableViewLoadNumber)
        //print(indexPath.row)
        
    }
    
    @IBAction func tableViewBackButton(sender: UIBarButtonItem) {
        tableViewLoadNumber -= 1
        self.arrayOfModelYears.removeAll()
        
        
        if tableViewLoadNumber < 0
        {
            tableViewLoadNumber = 0
        }
        makeTableView.reloadData()
    }
    
}