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
            
            // 加速度センサー（移動加速度）
            // X軸方向加速度
            var accelX = motion.userAcceleration.x
            accelX = round(accelX*1000)/1000
            xAccelLabel.text = String(accelX)
            // Y軸方向加速度
            var accelY = motion.userAcceleration.y
            accelY = round(accelY*1000)/1000
            yAccelLabel.text = String(accelY)
            // Z軸方向加速度
            var accelZ = motion.userAcceleration.z
            accelZ = round(accelZ*1000)/1000
            zAccelLabel.text = String(accelZ)
            
            // 重力ベクトル
            // 加速度のX成分
            var gravityX = motion.gravity.x
            gravityX = round(gravityX*100)/100
            xGravityLabel.text = String(gravityX)
            // 加速度のY成分
            var gravityY = motion.gravity.y
            gravityY = round(gravityY*100)/100
            yGravityLabel.text = String(gravityY)
            // 加速度のZ成分
            var gravityZ = motion.gravity.z
            gravityZ = round(gravityZ*100)/100
            zGravityLabel.text = String(gravityZ)
            
            // 姿勢センサー（回転角度　ラジアン）
            // ピッチ（X軸回り回転角度）
            var pitch = motion.attitude.pitch
            pitch = round(pitch*100)/100
            pitchLabel.text = String(pitch)
            // ロール（Y軸回り回転角度）
            var roll = motion.attitude.roll
            roll = round(roll*100)/100
            rollLabel.text = String(roll)
            // ヨー（Z軸回り回転角度）
            var yaw = motion.attitude.yaw
            yaw = round(yaw*100)/100
            yawLabel.text = String(yaw)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

