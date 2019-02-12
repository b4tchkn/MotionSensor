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
        /*
         //起動時ファイル削除用
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         //削除したいファイル名指定
         let filePath = dir.appendingPathComponent("kakeru_gyro.csv")
            
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                print("error")
            }
        }
        */
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSensorViewController") {
            let svc: SensorViewController = (segue.destination as? SensorViewController)!
            svc.fileName = inputText.text ?? ""
        }
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
