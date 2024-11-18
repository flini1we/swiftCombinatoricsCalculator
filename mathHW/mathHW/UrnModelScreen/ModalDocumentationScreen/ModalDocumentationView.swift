//
//  ModalDocumentationVIew.swift
//  mathHW
//
//  Created by Данил Забинский on 11.11.2024.
//

import UIKit

class ModalDocumentationView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var titleView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * 0.3),
        ])
        return view
    }()

    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Fonts.medium)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleView,
            subTitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.tiny
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(dataStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            titleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            dataStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.tiny),
            dataStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.tiny),
            dataStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.tiny),
            dataStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.tiny),
        ])
    }
}

