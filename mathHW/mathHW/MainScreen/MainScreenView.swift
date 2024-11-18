//
//  MainScreenView.swift
//  mathHW
//
//  Created by Данил Забинский on 07.11.2024.
//

import UIKit

class MainScreenView: UIView {
    
    var combinatoricsButtonTapped: (() -> Void)?
    var urnModelButtonTapped: (() -> Void)?
    
    /// First stackView image
    lazy var firstStackViewImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Colors.jetColor
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: Constants.medium),
        ])
        return image
    }()
    
    /// First stackView label
    lazy var firstStackViewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Fonts.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.jetColor
        return label
    }()
    
    /// First stackView subLabel
    lazy var firstStackViewSubLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.dimGray
        label.font = .systemFont(ofSize: Fonts.small)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Second stackView image
    lazy var secondStackViewImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Colors.jetColor
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: Constants.medium),
        ])
        return image
    }()
    
    /// Second stackView label
    lazy var secondStackViewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Fonts.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.jetColor
        return label
    }()
    
    /// Second stackView subLabel
    lazy var secondStackViewSubLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.dimGray
        label.font = .systemFont(ofSize: Fonts.small)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Third stackView image
    lazy var thirdStackViewImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Colors.jetColor
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: Constants.medium),
        ])
        return image
    }()
    
    /// Third stackView label
    lazy var thirdStackViewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Fonts.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.jetColor
        return label
    }()
    
    /// Third stackView subLabel
    lazy var thirdStackViewSubLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.dimGray
        label.font = .systemFont(ofSize: Fonts.small)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    /// Buttons
    lazy var combinatoricsButton: UIButton = {
        let buttonAction = UIAction { [weak self] _ in
            self?.combinatoricsButtonTapped?()
        }
        let button = UIButton(configuration: .bordered(), primaryAction: buttonAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.tiny
        button.clipsToBounds = true
        button.backgroundColor = Colors.carribianSea
        button.tintColor = .white
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constants.default),
            button.widthAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * Multipliers.threeQuarters),
        ])
        return button
    }()
    
    lazy var urnModelButton: UIButton = {
        let buttonAction = UIAction { [weak self] _ in
            self?.urnModelButtonTapped?()
        }
        let button = UIButton(configuration: .bordered(), primaryAction: buttonAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.carribianSea
        button.layer.cornerRadius = Constants.tiny
        button.clipsToBounds = true
        button.tintColor = .white
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constants.default),
            button.widthAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * Multipliers.threeQuarters),
        ])
        return button
    }()
    
    private lazy var initialImageView: UIImageView = {
        let iconImageView = UIImageView(image: .probability)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: max(Constants.screenHeight, Constants.screenWidth) * Multipliers.twoTenth)
        ])
        return iconImageView
    }()
    
    private lazy var firstDataStack: UIStackView = {
        let textStackView = UIStackView(arrangedSubviews: [
            self.firstStackViewLabel,
            self.firstStackViewSubLabel
        ])
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.alignment = .leading
        
        let dataStackView = UIStackView(arrangedSubviews: [
            self.firstStackViewImage,
            textStackView
        ])
        dataStackView.axis = .horizontal
        dataStackView.spacing = Constants.tiny
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        return dataStackView
    }()
    
    private lazy var secondDataStack: UIStackView = {
        lazy var textStackView = UIStackView(arrangedSubviews: [
            self.secondStackViewLabel,
            self.secondStackViewSubLabel
        ])
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.alignment = .leading
        
        lazy var dataStackView = UIStackView(arrangedSubviews: [
            self.secondStackViewImage,
            textStackView
        ])
        dataStackView.axis = .horizontal
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.spacing = Constants.tiny
        return dataStackView
    }()
    
    private lazy var thirdDataStack: UIStackView = {
        lazy var textStackView = UIStackView(arrangedSubviews: [
            self.thirdStackViewLabel,
            self.thirdStackViewSubLabel
        ])
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.alignment = .leading
        
        lazy var dataStackView = UIStackView(arrangedSubviews: [
            self.thirdStackViewImage,
            textStackView
        ])
        dataStackView.axis = .horizontal
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.spacing = Constants.tiny
        return dataStackView
    }()
    
    private lazy var dataStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstDataStack,
            secondDataStack,
            thirdDataStack
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.small
        return stack
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            combinatoricsButton,
            urnModelButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.tiny
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        scrollView.addSubview(initialImageView)
        scrollView.addSubview(dataStack)
        scrollView.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            initialImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.tiny),
            initialImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            dataStack.topAnchor.constraint(equalTo: initialImageView.bottomAnchor, constant: Constants.medium),
            dataStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            buttonsStackView.topAnchor.constraint(equalTo: dataStack.bottomAnchor, constant: Constants.medium),
            buttonsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.tiny),
        ])
    }
}
