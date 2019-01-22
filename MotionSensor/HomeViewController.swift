//
//  HomeViewController.swift
//  MotionSensor
//
//  Created by Kakeru Nakabachi on 2019/01/22.
//  Copyright © 2019 kakeru nakabachi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
}
