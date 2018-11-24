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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gvcLabel.text = textGVC
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
