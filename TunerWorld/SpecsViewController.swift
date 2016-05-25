//
//  SpecsViewController.swift
//  TunerWorld
//
//  Created by mobileapps on 5/18/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class SpecsViewController: UIViewController {
    
    @IBOutlet weak var infoTextView: UITextView!
    
    var selectedMake = ""
    var selectedModel = ""
    var selectedYear = ""
    
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
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTextView.text = "Year: \(selectedYear)\nMake: \(selectedMake)\nModel: \(selectedModel)\nENGINE\nEngineCode: \(engineCode)\nCylinders: \(cylinderCount)\nDisplacement: \(displacement)\nConfiguration: \(configuration)\nHorsepower: \(horsepower)\nTorque: \(torque)\nCompression Ratio: \(compressionRatio)\nAspiration: \(aspiration)\nPeak Power: \("

    }

 
    
    
    }


    
    


