//
//  WaterWaveViewController.swift
//  SampleCoreAnimation
//
//  Created by 张飞 on 2018/7/9.
//  Copyright © 2018年 张飞. All rights reserved.
//

import UIKit

class WaterWaveViewController: UIViewController {

    
    //三种颜色的layer
    var redShapeLayer:CAShapeLayer!
    var blueShapeLayer:CAShapeLayer!
    var yellowShapeLayer:CAShapeLayer!
    
    var waveDisplayLink:CADisplayLink!
    //波纹参数,以红色layer为基准进行调整
    let waveSpeed:CGFloat = 0.05
    let waveAmplitude:CGFloat = 8
    let waveHeight:CGFloat = AppInfo.screenHeight - 15
    let waveWidth:CGFloat = 6 * CGFloat(Double.pi)/AppInfo.screenWidth
    var offsetX:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        addWaveLayer()
    }
    
    ///添加波纹
    func addWaveLayer() {
        
        redShapeLayer = CAShapeLayer()
        redShapeLayer.fillColor = UIColor.red.cgColor
        redShapeLayer.opacity = 0.5
        self.view.layer.addSublayer(redShapeLayer)
        
        blueShapeLayer = CAShapeLayer()
        blueShapeLayer.fillColor = UIColor.blue.cgColor
        blueShapeLayer.opacity = 0.8
        self.view.layer.addSublayer(blueShapeLayer)
        
        yellowShapeLayer = CAShapeLayer()
        yellowShapeLayer.opacity = 0.6
        yellowShapeLayer.fillColor = UIColor.yellow.cgColor
        self.view.layer.addSublayer(yellowShapeLayer)
        
        waveDisplayLink = CADisplayLink.init(target: self, selector: #selector(waveLayer))
        waveDisplayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    @objc func waveLayer() {
        offsetX += waveSpeed
        
        let redPath = CGMutablePath()
        var redY:CGFloat = waveHeight
        redPath.move(to: CGPoint(x: 0, y: redY))
        for i in 0..<Int(AppInfo.screenWidth) {
            redY = waveAmplitude * sin(waveWidth * CGFloat(i) + offsetX) + waveHeight
            redPath.addLine(to: CGPoint(x: CGFloat(i), y: redY))
        }
        
        redPath.addLine(to: CGPoint(x: AppInfo.screenWidth, y: AppInfo.screenHeight))
        redPath.addLine(to: CGPoint(x: 0, y: AppInfo.screenHeight))
        redPath.closeSubpath()
        redShapeLayer.path = redPath
        
        let bluePath = CGMutablePath()
        var blueY:CGFloat = waveHeight
        bluePath.move(to: CGPoint(x: 0, y: blueY))
        for i in 0..<Int(AppInfo.screenWidth) {
            blueY = waveAmplitude * sin(0.8 * waveWidth * CGFloat(i) + offsetX + CGFloat(Double.pi * 0.2)) + waveHeight
            bluePath.addLine(to: CGPoint(x: CGFloat(i), y: blueY))
        }
        
        bluePath.addLine(to: CGPoint(x: AppInfo.screenWidth, y: AppInfo.screenHeight))
        bluePath.addLine(to: CGPoint(x: 0, y: AppInfo.screenHeight))
        bluePath.closeSubpath()
        blueShapeLayer.path = bluePath
        
        let yellowPath = CGMutablePath()
        var yellowY:CGFloat = waveHeight
        yellowPath.move(to: CGPoint(x: 0, y: yellowY))
        for i in 0..<Int(AppInfo.screenWidth) {
            yellowY = 0.75 * waveAmplitude * sin(0.6 * waveWidth * CGFloat(i) + offsetX + CGFloat(Double.pi * 0.3)) + waveHeight
            yellowPath.addLine(to: CGPoint(x: CGFloat(i), y: yellowY))
        }
        
        yellowPath.addLine(to: CGPoint(x: AppInfo.screenWidth, y: AppInfo.screenHeight))
        yellowPath.addLine(to: CGPoint(x: 0, y: AppInfo.screenHeight))
        yellowPath.closeSubpath()
        yellowShapeLayer.path = yellowPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
