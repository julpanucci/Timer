//
//  Countdown.swift
//  TImer
//
//  Created by Julian Panucci on 4/7/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit

class CountdownTimer: UIView {
    
    var countDownColor = UIColor.systemRed {
        didSet {
            self.circleLayer.strokeColor = self.countDownColor.cgColor
        }
    }
    
    var restColor: UIColor = UIColor.systemYellow {
        didSet {
            self.restLayer.strokeColor = self.restColor.cgColor
        }
    }
    
    var bgColor: UIColor = UIColor.lightGray {
        didSet {
            self.backgroundLayer.strokeColor = self.bgColor.cgColor
        }
    }
    
    var rest: Double? {
        didSet {
            if let rest = self.rest {
                self.restLabel.text = "\(rest)"
            }
            
        }
    }
    
    var resetOnFinish = false
    
    private let timeInterval = 0.001
    var duration = 5.0 {
        didSet {
            self.timeLeft = self.duration
            self.timerLabel.text = "\(Int(self.duration))"
        }
    }
    var timeLeft = 0.0
    var animationStarted = false
    var isPaused = false
    var timerStarted = false
    
    var timer: Timer?
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.customFont(.orbitron, type: .regular, size: 60)
        label.text = "\(Int(self.duration))"
        label.textAlignment = .center
        label.isHidden = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var restLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        if let rest = self.rest {
            label.text = "\(rest)"
        }
        label.textAlignment = .center
        label.isHidden = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: self.center, radius: 75.0, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        layer.path = circlePath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = self.countDownColor.cgColor
        layer.strokeEnd = 0
        layer.lineWidth = 10.0
        layer.lineCap = .round
        return layer
    }()
    
    lazy var restLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: self.center, radius: 75.0, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        layer.path = circlePath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = self.restColor.cgColor
        layer.strokeEnd = 0
        layer.lineWidth = 10.0
        layer.lineCap = .round
        return layer
    }()
    
    lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: self.center, radius: 75.0, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        layer.path = circlePath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = self.bgColor.cgColor
        layer.strokeEnd = 1
        layer.lineWidth = 15.0
        layer.lineCap = .round
        return layer
    }()
    
    var restAnimation = CABasicAnimation()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(restLayer)
        
        self.addSubview(timerLabel)
    }
    
    convenience init(frame: CGRect, rest: Double? = nil, resetOnFinish: Bool = false) {
        self.init(frame: frame)
        self.rest = rest
        self.resetOnFinish = resetOnFinish
        self.addSubview(restLabel)
    }
    
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            self.timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            self.timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.timerLabel.heightAnchor.constraint(equalToConstant: 90),
            self.timerLabel.widthAnchor.constraint(equalToConstant: self.frame.width),
            
            self.restLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40),
            self.restLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.restLabel.heightAnchor.constraint(equalToConstant: 30),
            self.restLabel.widthAnchor.constraint(equalToConstant: self.frame.width)
        ])
    }
    
    
    func resumeTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            
            self.timeLeft -= self.timeInterval
            if self.timeLeft <= 0 {
                self.timeLeft = 0.0
                timer.invalidate()
            }
            
            self.timerLabel.text = "\(Int(self.timeLeft))"
        }
    }
    
    func reset() {
        self.timer?.invalidate()
        self.timerLabel.text = "\(Int(self.duration))"
        self.timeLeft = self.duration
        restLayer.removeAllAnimations()
        circleLayer.removeAllAnimations()
        circleLayer.strokeColor = self.countDownColor.cgColor
        restLayer.strokeColor = self.restColor.cgColor
        backgroundLayer.strokeColor = self.bgColor.cgColor
        self.timerStarted = false
    }
    
    func startTimer() {
        self.animate()
        self.resumeTimer()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func animateRest() {
        restAnimation = CABasicAnimation(keyPath: "strokeEnd")
        restAnimation.fromValue = 0
        restAnimation.toValue = 1
        restAnimation.duration = CFTimeInterval(self.duration)
        restAnimation.fillMode = CAMediaTimingFillMode.both
        restAnimation.isRemovedOnCompletion = false
        restAnimation.delegate = self
        restLayer.add(restAnimation, forKey: "restAnimation")
    }
    
    func animate() {
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd")
        foregroundAnimation.fromValue = 0
        foregroundAnimation.toValue = 1
        foregroundAnimation.duration = CFTimeInterval(duration)
        foregroundAnimation.fillMode = CAMediaTimingFillMode.forwards
        foregroundAnimation.isRemovedOnCompletion = false
        foregroundAnimation.delegate = self
        circleLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
    }
    
    private func pauseAnimation(){
        let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleLayer.speed = 0.0
        circleLayer.timeOffset = pausedTime
        isPaused = true
        print("paused time: \(pausedTime)")
    }
    
    func resume() {
        resumeTimer()
        resumeAnimation()
    }
    
    func pause() {
        pauseAnimation()
        self.timer?.invalidate()
    }
    
    private func resumeAnimation(){
        isPaused = false
        let pausedTime = circleLayer.timeOffset
        circleLayer.speed = 1.0
        circleLayer.timeOffset = 0.0
        circleLayer.beginTime = 0.0
        let timeSincePause = circleLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleLayer.beginTime = timeSincePause
    }
    
    func completeAnimation() {
        UIDevice.vibrate()
        UIDevice.vibrate()
        UIDevice.vibrate()
        
        self.backgroundLayer.strokeColor = UIColor.white.cgColor
        self.restLayer.strokeColor = UIColor.systemGreen.cgColor
        self.circleLayer.strokeColor = UIColor.systemGreen.cgColor
    }
    
    
}

extension CountdownTimer: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        self.timerStarted = true
        
        
        print("Animation started")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == restLayer.animation(forKey: "restAnimation"), flag {
            self.timerStarted = false
            self.completeAnimation()
            
            if resetOnFinish {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.reset()
                }
            }
        } else {
            if let rest = self.rest, flag {
                self.timer?.invalidate()
                self.duration = rest
                self.resumeTimer()
                self.animateRest()
            } else {
                if flag {
                    if resetOnFinish {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.reset()
                        }
                    }
                    self.timerStarted = false
                    self.completeAnimation()
                }
            }
        }
        
        
        print("Did animation finish: \(flag)")
    }
}

