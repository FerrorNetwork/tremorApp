//
//  ViewController.swift
//  tremorApp
//
//  Created by Данил on 05.05.2023.
//

import UIKit
import CoreMotion

final class TremorAnalizeViewController: UIViewController {

        var count = 10
        var timer = Timer()
        let motion = CMMotionManager()
        


        
        let timerLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
    
        let buttonTimer: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor.black
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 0
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            return button
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpUI()
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
        @objc func updateTimer() {
            count -= 1
            timerLabel.text = "\(count)"
            if count == 0 {
                timer.invalidate()
                showAlert()
                buttonTimer.isHidden = false
                count = 10
                timerLabel.text = "\(count)"
            }
        }
        
        func showAlert() {
            let alert = UIAlertController(title: "Time's up!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        @objc func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            buttonTimer.isHidden = true
            
            var xAccelerationArray = [Double]()
            var yAccelerationArray = [Double]()
            var zAccelerationArray = [Double]()
            
            if motion.isAccelerometerAvailable {
                motion.accelerometerUpdateInterval = 0.1
                
                motion.startAccelerometerUpdates(to: .main) { (data, error) in
                    if let acceleration = data?.acceleration {
                        let x = acceleration.x
                        let y = acceleration.y
                        let z = acceleration.z
                        
                        xAccelerationArray.append(x)
                        yAccelerationArray.append(y)
                        zAccelerationArray.append(z)
                        
                        print("Acceleration: x = \(x), y = \(y), z = \(z)")
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.motion.stopAccelerometerUpdates()
                    
                    let xAverageAcceleration = xAccelerationArray.reduce(0, +) / Double(xAccelerationArray.count)
                    let yAverageAcceleration = yAccelerationArray.reduce(0, +) / Double(yAccelerationArray.count)
                    let zAverageAcceleration = zAccelerationArray.reduce(0, +) / Double(zAccelerationArray.count)
                    
                    let xDeviationArray = xAccelerationArray.map { $0 - xAverageAcceleration }
                    let yDeviationArray = yAccelerationArray.map { $0 - yAverageAcceleration }
                    let zDeviationArray = zAccelerationArray.map { $0 - zAverageAcceleration }
                    
                    let xSquaredDeviations = xDeviationArray.map { $0 * $0 }
                    let ySquaredDeviations = yDeviationArray.map { $0 * $0 }
                    let zSquaredDeviations = zDeviationArray.map { $0 * $0 }

                    let sumOfSquaredDeviations = xSquaredDeviations.reduce(0, +) + ySquaredDeviations.reduce(0, +) + zSquaredDeviations.reduce(0, +)
                    
                    let variance = sumOfSquaredDeviations / Double(xDeviationArray.count - 1)
                    
                    let standardDeviation = sqrt(variance)

                    
                    print("Average acceleration: x = \(xAverageAcceleration), y = \(yAverageAcceleration), z = \(zAverageAcceleration)")
                }
            } else {
                print("Accelerometer is not available")
            }


        }
    
        func setUpUI() {
            view.addSubview(timerLabel)
            view.addSubview(buttonTimer)
            timerLabel.text = "\(count)"
            buttonTimer.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
            let attributedString = NSAttributedString(string: NSLocalizedString("Начать анализ", comment: ""), attributes:[
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0),
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.underlineStyle: 0
            ])
            buttonTimer.setAttributedTitle(attributedString, for: .normal)
            self.addConstraint()
        }
    
    func addConstraint() {
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonTimer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonTimer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonTimer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonTimer.heightAnchor.constraint(equalToConstant: 50)

        ])

    }
}

