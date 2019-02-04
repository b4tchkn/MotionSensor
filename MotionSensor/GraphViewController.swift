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
    
    var textGVC: String?
    var xGyroData:[Double]?
    var yGyroData:[Double]?
    var zGyroData:[Double]?
    
    var xAccelData:[Double]?
    var yAccelData:[Double]?
    var zAccelData:[Double]?
    
    var xGravityData:[Double]?
    var yGravityData:[Double]?
    var zGravityData:[Double]?
    
    var pitchData:[Double]?
    var rollData:[Double]?
    var yawData:[Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textGVC = xAccelData?.count
        gvcLabel.text = xAccelData?.count.description
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
