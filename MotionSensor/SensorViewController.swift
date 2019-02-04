//
//  SensorViewController.swift
//  MotionSensor
//
//  Created by Kakeru Nakabachi on 2018/11/22.
//  Copyright © 2018 kakeru nakabachi. All rights reserved.
//

import UIKit
import CoreMotion

class SensorViewController: UIViewController {

    // ジャイロスコープの測定値保存
    var xGyroData:[Double] = []
    var yGyroData:[Double] = []
    var zGyroData:[Double] = []
    
    // 加速度の測定値保存
    var xAccelData:[Double] = []
    var yAccelData:[Double] = []
    var zAccelData:[Double] = []
    
    // 加速度のベクトル保存
    var xGravityData:[Double] = []
    var yGravityData:[Double] = []
    var zGravityData:[Double] = []
    
    // 姿勢の測定値保存
    var pitchData:[Double] = []
    var rollData:[Double] = []
    var yawData:[Double] = []
    
    // 加速度の測定値
    @IBOutlet weak var xAccelLabel: UILabel!
    @IBOutlet weak var yAccelLabel: UILabel!
    @IBOutlet weak var zAccelLabel: UILabel!
    
    // count
    @IBOutlet weak var dataCountLabel: UILabel!
    
    
    // モーションマネージャ生成
    let motionManager = CMMotionManager()
    // センサの値を読み取るためのキューを実行する間隔（秒数）
    let dt = 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // センサの値を読み取るためのキューを実行する間隔（秒数）の設定
        motionManager.deviceMotionUpdateInterval = dt
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
            let gyroX = motion.rotationRate.x
            xGyroData.append(gyroX)
            // Y軸回り回転角速度
            let gyroY = motion.rotationRate.y
            yGyroData.append(gyroY)
            // Z軸回り回転角速度
            let gyroZ = motion.rotationRate.z
            zGyroData.append(gyroZ)
            
            // 加速度センサー（移動加速度）
            // X軸方向加速度
            let accelX = motion.userAcceleration.x
            xAccelLabel.text = String(accelX)
            xAccelData.append(motion.userAcceleration.x)
            // Y軸方向加速度
            let accelY = motion.userAcceleration.y
            yAccelLabel.text = String(accelY)
            yAccelData.append(motion.userAcceleration.y)
            // Z軸方向加速度
            let accelZ = motion.userAcceleration.z
            zAccelLabel.text = String(accelZ)
            zAccelData.append(motion.userAcceleration.z)
            
            // 重力ベクトル
            // 加速度のX成分
            let gravityX = motion.gravity.x
            xGyroData.append(gravityX)
            // 加速度のY成分
            let gravityY = motion.gravity.y
            yGyroData.append(gravityY)
            // 加速度のZ成分
            let gravityZ = motion.gravity.z
            zGyroData.append(gravityZ)
            
            // 姿勢センサー（回転角度　ラジアン）
            // ピッチ（X軸回り回転角度）
            let pitch = motion.attitude.pitch
            pitchData.append(pitch)
            // ロール（Y軸回り回転角度）
            let roll = motion.attitude.roll
            rollData.append(roll)
            // ヨー（Z軸回り回転角度）
            let yaw = motion.attitude.yaw
            yawData.append(yaw)
            
            dataCountLabel.text = String(xAccelData.count)
            print(xAccelData.count)
        }
    }
    @IBAction func resetButtonTapped(_ sender: Any) {
        print("resetButtonTapped")
        print(xAccelData.count)
        
        // 配列リセット
        xGyroData.removeAll()
        yGyroData.removeAll()
        zGyroData.removeAll()
        
        xAccelData.removeAll()
        yAccelData.removeAll()
        zAccelData.removeAll()
        
        xGravityData.removeAll()
        yGravityData.removeAll()
        zGravityData.removeAll()
        
        pitchData.removeAll()
        rollData.removeAll()
        yawData.removeAll()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("saveButtonTapped")
        performSegue(withIdentifier: "toGraphViewController", sender: nil)
        stopMotionAnimation()
    }

    
    // Segue準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGraphViewController") {
            let gvc: GraphViewController = (segue.destination as? GraphViewController)!
            // GraphViewControllerにメッセージを設定
            gvc.textGVC = "to GVC"
            
            gvc.xGyroData = xGyroData
            gvc.yGyroData = yGyroData
            gvc.zGyroData = zGyroData
            
            gvc.xAccelData = xAccelData
            gvc.yAccelData = yAccelData
            gvc.zAccelData = zAccelData
            
            gvc.xGravityData = xGravityData
            gvc.yGravityData = yGravityData
            gvc.zGravityData = zGravityData
            
            gvc.pitchData = pitchData
            gvc.rollData = rollData
            gvc.yawData = yawData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func backButtonTapped(_ sender: Any) {
        print("backButtonTapped")
        stopMotionAnimation()
        performSegue(withIdentifier: "toHomeViewController", sender: nil)
    }
    
    func stopMotionAnimation() {
        if (motionManager.isDeviceMotionActive) {
            print("stopMotion")
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

