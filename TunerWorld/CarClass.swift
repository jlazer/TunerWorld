//
//  CarClass.swift
//  TunerWorld
//
//  Created by student1 on 5/12/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import Foundation

class Car
{
    var make: String
    var model: String
    var year: NSNumber
    var engine: String
    var transmission: String
    
    
    init(make mk: String, model md: String, year y: NSNumber)
    {
        make = mk
        model = md
        year = y
        engine = ""
        transmission = ""
    }
    
    
    
    init(make mk: String, model md: String, year y: NSNumber, engine e: String, transmission t: String)
    {
        make = mk
        model = md
        year = y
        engine = e
        transmission = t
        
    }
    
    init ()
    {
        make = ""
        model = ""
        year = NSNumber()
        engine = ""
        transmission = ""
    }
    
}