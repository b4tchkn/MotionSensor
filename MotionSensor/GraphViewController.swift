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
        
        let gyroCSV = csvGenerate(datas: gyroData)
        let accelCSV = csvGenerate(datas: accelData)
        let gravityCSV = csvGenerate(datas: gravityData)
        let positionCSV = csvGenerate(datas: positionData)
        
        createFile(gyroCSV, dataType: "gyro")
        createFile(accelCSV, dataType: "accel")
        createFile(gravityCSV, dataType: "gravity")
        createFile(positionCSV, dataType: "position")
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    // csvFile生成
    func createFile(_ csvString: String, dataType: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent("\(fileName)_\(dataType).csv")
            
            do {
                try csvString.write(to: filePath, atomically: true, encoding: .utf8)
            } catch {
                print("file error")
            }
        }
    }
    
    // csvString生成
    func csvGenerate(datas: [[String]]) -> String {
        var csv = ""
        
        for i in 0 ..< datas.count {
            for data in datas[i] {
                csv += data
                if data != datas[i].last {
                    csv += ","
                } else {
                    csv += "\n"
                }
            }
        }
        return csv
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
