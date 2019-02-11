//
//  HomeViewController.swift
//  MotionSensor
//
//  Created by Kakeru Nakabachi on 2019/01/22.
//  Copyright © 2019 kakeru nakabachi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSensorViewController", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
