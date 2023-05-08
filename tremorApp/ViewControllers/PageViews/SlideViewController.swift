//
//  SlideViewController.swift
//  tremorApp
//
//  Created by Данил on 05.05.2023.
//
import UIKit

class SlideViewController: UIViewController {
    var index: Int = 0
    var titleText: String?
    var imageName: String?
    
    let button = UIButton(type: .system)

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let titleText = titleText {
            titleLabel.text = titleText
            view.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                titleLabel.heightAnchor.constraint(equalToConstant: 150),
                titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
            ])
        }
        
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
            view.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
            ])
        }
        
            button.backgroundColor = UIColor.black
            button.setTitleColor(UIColor.white, for: .normal)
//            button.setTitle("Вперед!", for: .normal)
            let attributedString = NSAttributedString(string: NSLocalizedString("Вперед!", comment: ""), attributes:[
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0),
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.underlineStyle: 0
            ])
            button.setAttributedTitle(attributedString, for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.layer.borderWidth = 0
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            view.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 35)
            ])

        
    }
}

extension SlideViewController {
    @objc func buttonTapped() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
