//
//  ViewController.swift
//  TImer
//
//  Created by Julian Panucci on 4/2/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timeLeft: Double = 5.0 {
        didSet {
            self.countDownTimer.duration = self.timeLeft
            self.countDownTimer.reset()
        }
    }
    let countDownTimer = CountdownTimer(frame: CGRect(x: 0, y: 0, width: 100, height: 100), rest: nil)
    
    lazy var button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("10s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    lazy var button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("20s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    lazy var button3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("30s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    lazy var restButton1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("10s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(restButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    lazy var restButton2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("20s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(restButtonTapped2), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    lazy var restButton3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("30s", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        button.addTarget(self, action: #selector(restButtonTapped3), for: .touchUpInside)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    lazy var resetsSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(self, action: #selector(switchTapped(sender:)), for: .valueChanged)
        return s
    }()
    
    
    @objc func button1Tapped() {
        self.timeLeft = 10.0
    }
    @objc func button2Tapped() {
        self.timeLeft = 20.0
    }
    @objc func button3Tapped() {
        self.timeLeft = 30.0
    }
    
    @objc func restButtonTapped() {
        self.countDownTimer.rest = 10.0
    }
    @objc func restButtonTapped2() {
        self.countDownTimer.rest = 20.0
    }
    @objc func restButtonTapped3() {
        self.countDownTimer.rest = 30.0
    }
    
    var stack1 = UIStackView()
    var stack2 = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBlue
        
        countDownTimer.center = self.view.center
        countDownTimer.duration = self.timeLeft
        countDownTimer.countDownColor = UIColor.systemRed
        
        self.view.addSubview(countDownTimer)
        stack1 = UIStackView(arrangedSubviews: [button1, button2, button3])
        stack1.translatesAutoresizingMaskIntoConstraints = false
        stack1.alignment = .center
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 8.0
        
        stack2 = UIStackView(arrangedSubviews: [restButton1, restButton2, restButton3])
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.alignment = .center
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 8.0
        
        self.view.addSubview(stack1)
        self.view.addSubview(stack2)
        self.view.addSubview(resetsSwitch)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stack1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            stack1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            stack1.heightAnchor.constraint(equalToConstant: 60),
            
            stack2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            stack2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            stack2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            stack2.heightAnchor.constraint(equalToConstant: 60),
            
            resetsSwitch.bottomAnchor.constraint(equalTo: self.stack2.topAnchor, constant: -24),
            resetsSwitch.leadingAnchor.constraint(equalTo: self.stack2.leadingAnchor, constant: 0),
            resetsSwitch.widthAnchor.constraint(equalToConstant: 50),
            resetsSwitch.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func switchTapped(sender: UISwitch) {
        countDownTimer.resetOnFinish = sender.isOn
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if countDownTimer.timerStarted {
            if countDownTimer.isPaused {
                countDownTimer.resume()
            } else {
                countDownTimer.pause()
            }
        } else {
            countDownTimer.startTimer()
        }
    }
}

