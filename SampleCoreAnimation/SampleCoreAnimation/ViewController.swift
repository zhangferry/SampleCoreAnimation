//
//  ViewController.swift
//  SampleCoreAnimation
//
//  Created by 张飞 on 2018/7/9.
//  Copyright © 2018年 张飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        addSubline()
        testBezierCircle()
    }
    
    func testBezierCircle() {
        //使用贝塞尔曲线画圆，中心不好确定
        let path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 40 * 2, height: 40 * 2))

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        layer.path = path.cgPath
        layer.position = self.view.center
        layer.fillColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
        
        self.view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.toValue = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        animation.duration = 2
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
        
    }
    
    func addSubline() {
        let horizontalLine = CALayer()
        horizontalLine.frame = CGRect(x: 0, y: AppInfo.screenHeight/2, width: AppInfo.screenWidth, height: 1)
        horizontalLine.backgroundColor = UIColor.brown.cgColor
        self.view.layer.addSublayer(horizontalLine)
        
        let verticalLine = CALayer()
        verticalLine.frame = CGRect(x: AppInfo.screenWidth/2, y: 0, width: 1, height: AppInfo.screenHeight)
        verticalLine.backgroundColor = UIColor.brown.cgColor
        self.view.layer.addSublayer(verticalLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

