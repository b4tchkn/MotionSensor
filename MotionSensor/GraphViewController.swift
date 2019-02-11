//
//  GraphViewController.swift
//  MotionSensor
//
//  Created by Kakeru Nakabachi on 2018/11/24.
//  Copyright © 2018 kakeru nakabachi. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var gvcLabel: UILabel!
    
    var gyroData = [[String]]()
    var accelData = [[String]]()
    var gravityData = [[String]]()
    var positionData = [[String]]()
    
    var fileName = ""
    var csvString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        gvcLabel.text = String(gyroData.count)
        print("gyroData.count:\(gyroData.count)")
        print("accelData.count:\(accelData.count)")
        print("gravityData.count:\(gravityData.count)")
        print("positionData.count:\(positionData.count)")
        
        for i in 0 ..< gyroData.count {
            for data in gyroData[i] {
                csvString += data
                if data != gyroData[i].last {
                    csvString += "\t"
                } else {
                    csvString += "\n"
                }
            }
        }
        
        print(csvString)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent("\(fileName)_gyro.tsv")
            
            do {
                print("filePath -> \(filePath)")
                print("testing")
                try csvString.write(to: filePath, atomically: true, encoding: .utf8)
            } catch {
                print("error")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
