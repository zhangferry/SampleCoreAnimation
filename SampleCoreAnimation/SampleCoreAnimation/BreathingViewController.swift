//
//  BreathingViewController.swift
//  SampleCoreAnimation
//
//  Created by 张飞 on 2018/7/9.
//  Copyright © 2018年 张飞. All rights reserved.
//

import UIKit

class BreathingViewController: UIViewController {

    var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        contentView = UIView()
        //contentView.backgroundColor = UIColor.brown
        contentView.frame = CGRect(x: 0, y: 0, width: 218, height: 218)
        self.view.addSubview(contentView)
        contentView.center = self.view.center
        
        addBreatheAnimation(radius: 10, scale: 5, duration: 4)
    }
    
    //小圆半径，放大倍数, 动画周期
    func addBreatheAnimation(radius:CGFloat, scale:CGFloat, duration: Double) {
        
        for index in 0..<6 {
            
            let center = CGPoint(x: contentView.bounds.width/2, y: contentView.bounds.height/2)
            //使用贝塞尔曲线画圆，设置layer的frame和position
            let path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: radius * 2, height: radius * 2))

            let layer = CAShapeLayer()
            layer.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            layer.position = center
            layer.path = path.cgPath
            layer.fillColor = UIColor.init(red: 1, green: 0, blue: 1, alpha: 0.5).cgColor
            contentView.layer.addSublayer(layer)
            
            let animation1 = CABasicAnimation()
            animation1.keyPath = "position"
            
            var endPoint:CGPoint!
            
            switch index{
            case 0:
                endPoint = CGPoint(x:center.x + radius * scale,y:center.y)
            case 1:
                endPoint = CGPoint(x:center.x + radius * scale * 0.5,y:center.y - radius * scale * 0.5 * sqrt(3))
            case 2:
                endPoint = CGPoint(x:center.x - radius * scale * 0.5,y:center.y - radius * scale * 0.5 * sqrt(3))
            case 3:
                endPoint = CGPoint(x:center.x - radius * scale,y:center.y)
            case 4:
                endPoint = CGPoint(x:center.x - radius * scale * 0.5,y:center.y + radius * scale * 0.5 * sqrt(3))
            case 5:
                endPoint = CGPoint(x:center.x + radius * scale * 0.5,y:center.y + radius * scale * 0.5 * sqrt(3))
            default:
                layer.removeFromSuperlayer()
                continue
            }
            animation1.toValue = endPoint
            
            let animation2 = CABasicAnimation()
            animation2.keyPath = "transform.scale"
            animation2.toValue = scale
            //add group animation
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [animation1, animation2]
            animationGroup.duration = duration
            animationGroup.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            animationGroup.repeatCount = MAXFLOAT
            animationGroup.autoreverses = true
            layer.add(animationGroup, forKey: nil)
        }
        //整体旋转
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.toValue = Double.pi
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        animation.duration = duration
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        contentView.layer.add(animation, forKey: nil)
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
