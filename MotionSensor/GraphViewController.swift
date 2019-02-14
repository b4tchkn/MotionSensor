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
        
        gvcLabel.text = String(accelData.count)
        
        for i in 0 ..< accelData.count {
            for data in accelData[i] {
                csvString += data
                if data != accelData[i].last {
                    csvString += ","
                } else {
                    csvString += "\n"
                }
            }
        }

        print(csvString)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent("\(fileName)_accel.csv")
            
            do {
                print("filePath -> \(filePath)")
                try csvString.write(to: filePath, atomically: true, encoding: .utf8)
            } catch {
                print("file error")
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
