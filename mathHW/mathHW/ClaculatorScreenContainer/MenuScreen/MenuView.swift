//
//  MenuView.swift
//  mathHW
//
//  Created by Данил Забинский on 17.11.2024.
//

import UIKit

class MenuView: UIView {
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "house"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = Colors.powderBlue
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: Constants.huge),
            button.heightAnchor.constraint(equalToConstant: Constants.huge)
        ])
        button.layer.cornerRadius = Constants.huge / 2
        return button
    }()

    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = Colors.whiteGray
        addSubview(title)
        addSubview(button)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.medium),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            button.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.tiny),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
