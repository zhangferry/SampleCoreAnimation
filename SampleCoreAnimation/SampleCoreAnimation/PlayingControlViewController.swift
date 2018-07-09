//
//  PlayingControlViewController.swift
//  SampleCoreAnimation
//
//  Created by 张飞 on 2018/7/9.
//  Copyright © 2018年 张飞. All rights reserved.
//

import UIKit

class PlayingControlViewController: UIViewController {
    private var sSizeLayer: CAShapeLayer!
    private var mSizeLayer: CAShapeLayer!
    private var lSizeLayer: CAShapeLayer!
    
    private let sScale: CGFloat = 1.42
    private let mScale: CGFloat = 1.83
    private let lScale: CGFloat = 2.25
    
    let radius: CGFloat = 36 //小圆半径
    let playBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //view.backgroundColor = UIColor.white
        view.layer.contents = #imageLiteral(resourceName: "icon_bg_02").cgImage
        setupUI()
    }
    
    func setupUI() {
        addRippleAnimation()
        startAction()
    }
    
    func addRippleAnimation() {
        
        sSizeLayer = CAShapeLayer()
        sSizeLayer.cornerRadius = radius
        sSizeLayer.masksToBounds = true
        sSizeLayer.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        sSizeLayer.position = view.center
        sSizeLayer.backgroundColor = UIColor(white: 1, alpha: 0.25).cgColor
        mSizeLayer = CAShapeLayer()
        mSizeLayer.cornerRadius = radius
        mSizeLayer.masksToBounds = true
        mSizeLayer.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        mSizeLayer.position = view.center
        mSizeLayer.backgroundColor = UIColor(white: 1, alpha: 0.25).cgColor
        lSizeLayer = CAShapeLayer()
        lSizeLayer.cornerRadius = radius
        lSizeLayer.masksToBounds = true
        lSizeLayer.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        lSizeLayer.position = view.center
        lSizeLayer.backgroundColor = UIColor(white: 1, alpha: 0.15).cgColor
        
        view.layer.addSublayer(sSizeLayer)
        view.layer.addSublayer(mSizeLayer)
        view.layer.addSublayer(lSizeLayer)
        
        playBtn.backgroundColor = UIColor.white
        playBtn.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        playBtn.center = self.view.center
        playBtn.layer.cornerRadius = radius
        playBtn.layer.masksToBounds = true
        playBtn.setImage(#imageLiteral(resourceName: "icon_play"), for: .normal)
        playBtn.setImage(#imageLiteral(resourceName: "icon_pause"), for: .selected)
        playBtn.addTarget(self, action: #selector(playControl(_:)), for: .touchUpInside)
        view.addSubview(playBtn)
        playBtn.isSelected = true
    }
    
    @objc func playControl(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            playAction()
        } else {
            pauseAction()
        }
    }
    //正在播放
    @objc func playingState() {
        let sAnimation = self.createAnimation(duration: 4, value: [sScale, sScale + 0.1, sScale - 0.1], isRepeat: true)
        sAnimation.autoreverses = true
        sSizeLayer.add(sAnimation, forKey: "s.play")
        let mAnimation = self.createAnimation(duration: 4, value: [mScale, mScale - 0.1, mScale, mScale + 0.1], isRepeat: true)
        mAnimation.autoreverses = true
        mSizeLayer.add(mAnimation, forKey: "m.play")
        let lAnimation = self.createAnimation(duration: 4, value: [lScale, lScale + 0.1, lScale - 0.1], isRepeat: true)
        lAnimation.autoreverses = true
        lSizeLayer.add(lAnimation, forKey: "l.play")
    }
    
    func createAnimation(duration:Double, value:[Any], isRepeat: Bool) -> CAKeyframeAnimation{
        let timingFunction = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        let sAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        sAnimation.duration = duration
        sAnimation.timingFunctions = timingFunction
        sAnimation.isRemovedOnCompletion = false //进入后台动画不停止
        sAnimation.fillMode = kCAFillModeForwards
        sAnimation.repeatCount = isRepeat ? MAXFLOAT : 1.0
        //sAnimation.autoreverses = true
        sAnimation.values = value//1.42//1.83,2.25
        return sAnimation
    }

    func startAction() {
        let sAnimation = self.createAnimation(duration: 0.5, value: [1, sScale], isRepeat: false)
        sSizeLayer.add(sAnimation, forKey: "s.play")
        let mAnimation = self.createAnimation(duration: 0.75, value: [1, sScale, mScale], isRepeat: false)
        mSizeLayer.add(mAnimation, forKey: "m.play")
        let lAnimation = self.createAnimation(duration: 1, value: [1, sScale, mScale, lScale], isRepeat: false)
        lSizeLayer.add(lAnimation, forKey: "l.play")
        //1s之后进入播放状态
        self.perform(#selector(playingState), with: nil, afterDelay: 1)
    }

    func playAction() {
        let sAnimation = self.createAnimation(duration: 0.5, value: [1.25, sScale], isRepeat: false)
        sAnimation.keyTimes = [0.1, 0.5]
        sSizeLayer.add(sAnimation, forKey: "s.play")
        let mAnimation = self.createAnimation(duration: 0.75, value: [1.5, mScale], isRepeat: false)
        mAnimation.keyTimes = [0.15, 0.75]
        mSizeLayer.add(mAnimation, forKey: "m.play")
        let lAnimation = self.createAnimation(duration: 1, value: [1.7, lScale], isRepeat: false)
        lAnimation.keyTimes = [0.25, 1]
        lSizeLayer.add(lAnimation, forKey: "l.play")
        //1s之后进入播放状态
        self.perform(#selector(playingState), with: nil, afterDelay: 1)
    }
  
    func pauseAction() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(playingState), object: nil)
        let sAnimation = self.createAnimation(duration: 0.5, value: [sScale, 1.25], isRepeat: false)
        sAnimation.keyTimes = [0.1, 0.5]
        sSizeLayer.add(sAnimation, forKey: "s.play")
        let mAnimation = self.createAnimation(duration: 0.75, value: [mScale, 1.5], isRepeat: false)
        mAnimation.keyTimes = [0.15, 0.75]
        mSizeLayer.add(mAnimation, forKey: "m.play")
        let lAnimation = self.createAnimation(duration: 1, value: [lScale, 1.7], isRepeat: false)
        lAnimation.keyTimes = [0.25, 1]
        lSizeLayer.add(lAnimation, forKey: "l.play")
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
