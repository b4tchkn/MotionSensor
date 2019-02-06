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
    var gyroData = [[String]]()
    // 加速度の測定値保存
    var accelData = [[String]]()
    // 加速度のベクトル保存
    var gravityData = [[String]]()
    // 姿勢の測定値保存
    var positionData = [[String]]()
    
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
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.ReferenceType.local
            formatter.dateFormat = "HH:mm:ss.SSS"
            let date = Date()
            let dateStr = formatter.string(from: date)
            
            // ジャイロスコープ（回転速度）
            // X軸回り回転角速度
            let gyroX = motion.rotationRate.x
            // Y軸回り回転角速度
            let gyroY = motion.rotationRate.y
            // Z軸回り回転角速度
            let gyroZ = motion.rotationRate.z
            gyroData.append([String(dateStr), String(gyroX), String(gyroY), String(gyroZ)])
            
            // 加速度センサー（移動加速度）
            // X軸方向加速度
            let accelX = motion.userAcceleration.x
            xAccelLabel.text = String(accelX)
            // Y軸方向加速度
            let accelY = motion.userAcceleration.y
            yAccelLabel.text = String(accelY)
            // Z軸方向加速度
            let accelZ = motion.userAcceleration.z
            zAccelLabel.text = String(accelZ)
            accelData.append([String(dateStr), String(accelX), String(accelY), String(accelZ)])
            
            // 重力ベクトル
            // 加速度のX成分
            let gravityX = motion.gravity.x
            // 加速度のY成分
            let gravityY = motion.gravity.y
            // 加速度のZ成分
            let gravityZ = motion.gravity.z
            gravityData.append([String(dateStr), String(gravityX), String(gravityY), String(gravityZ)])
            
            // 姿勢センサー（回転角度　ラジアン）
            // ピッチ（X軸回り回転角度）
            let pitch = motion.attitude.pitch
            // ロール（Y軸回り回転角度）
            let roll = motion.attitude.roll
            // ヨー（Z軸回り回転角度）
            let yaw = motion.attitude.yaw
            positionData.append([String(dateStr), String(pitch), String(roll), String(yaw)])
            
            dataCountLabel.text = String(gyroData.count)
        }
    }
    @IBAction func resetButtonTapped(_ sender: Any) {
        print("resetButtonTapped")
        
        // 配列リセット
        gyroData.removeAll()
        accelData.removeAll()
        gravityData.removeAll()
        positionData.removeAll()
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
            gvc.gyroData = gyroData
            gvc.accelData = accelData
            gvc.gravityData = gravityData
            gvc.positionData = positionData
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

