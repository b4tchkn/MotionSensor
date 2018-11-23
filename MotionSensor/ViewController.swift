//
//  ViewController.swift
//  MotionSensor
//
//  Created by Kakeru Nakabachi on 2018/11/22.
//  Copyright © 2018 kakeru nakabachi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    // ジャイロスコープの測定値
    @IBOutlet weak var xGyroLabel: UILabel!
    @IBOutlet weak var yGyroLabel: UILabel!
    @IBOutlet weak var zGyroLabel: UILabel!
    
    // 加速度の測定値
    @IBOutlet weak var xAccelLabel: UILabel!
    @IBOutlet weak var yAccelLabel: UILabel!
    @IBOutlet weak var zAccelLabel: UILabel!
    
    // 加速度のベクトル
    @IBOutlet weak var xGravityLabel: UILabel!
    @IBOutlet weak var yGravityLabel: UILabel!
    @IBOutlet weak var zGravityLabel: UILabel!
    
    // 姿勢の測定値
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!
    
    // モーションマネージャ生成
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // センサの値を読み取るためのキューを実行する間隔（秒数）
        motionManager.deviceMotionUpdateInterval = 0.1
        // キュー実行するクロージャ
        let handler:CMDeviceMotionHandler = {(motionData:CMDeviceMotion?, error:Error?) -> Void in
            self.motionAnimation(motionData, error: error as NSError?)
        }
        // 更新で実行するキューを登録してモーションセンサーをスタートする
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: handler)
    }

    func motionAnimation(_ motionData:CMDeviceMotion?, error:NSError?) {
        if let motion = motionData {
            // ジャイロスコープ（回転速度）
            // X軸回り回転角速度
            var gyroX = motion.rotationRate.x
            gyroX = round(gyroX*100)/100
            xGyroLabel.text = String(gyroX)
            // Y軸回り回転角速度
            var gyroY = motion.rotationRate.y
            gyroY = round(gyroY*100)/100
            yGyroLabel.text = String(gyroY)
            // Z軸回り回転角速度
            var gyroZ = motion.rotationRate.z
            gyroZ = round(gyroZ*100)/100
            zGyroLabel.text = String(gyroZ)
            
        }
    }

}

