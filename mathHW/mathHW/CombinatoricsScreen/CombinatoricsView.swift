//
//  CombinatoricsViewController.swift
//  mathHW
//
//  Created by Данил Забинский on 07.11.2024.
//

import UIKit

class CombinatoricsView: UIView {
    
    var typesSegmentControlAction: (() -> Void)?
    var repetitionSegmentControlAction: (() -> Void)?

    var acceptButtonAction: (() -> Void)?
    
    lazy var invalidDataAlert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        return alert
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var initialTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Fonts.title)
        return label
    }()
    
    lazy var typesSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        let segmentControlAction = UIAction { [weak self] _ in
            guard let self else { return }
            typesSegmentControlAction?()
        }
        segmentControl.backgroundColor = Colors.powderBlue
        segmentControl.addAction(segmentControlAction, for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.medium)
        ])
        return segmentControl
    }()
    
    lazy var repetitionSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        let segmentControlAction = UIAction { [weak self] _ in
            guard let self else { return }
            repetitionSegmentControlAction?()
        }
        segmentControl.backgroundColor = Colors.powderBlue
        segmentControl.addAction(segmentControlAction, for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.medium)
        ])
        return segmentControl
    }()
    
    private lazy var segmentsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            typesSegmentControl,
            repetitionSegmentControl,
        ])
        stack.axis = .vertical
        stack.spacing = Constants.small
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var acceptButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.acceptButtonAction?()
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Подтвердить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.carribianSea
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constants.medium)
        ])
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = Constants.tiny
        return scrollView
    }()
    
    lazy var documentationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Fonts.title)
        return label
    }()
    
    lazy var documentationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Fonts.medium)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var documentationStackView: UIStackView = {
        let dataStackView = UIStackView(arrangedSubviews: [
            documentationTitle,
            documentationLabel,
        ])
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.axis = .vertical
        dataStackView.spacing = Constants.tiny
        dataStackView.alignment = .leading
        return dataStackView
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            initialTextLabel,
            segmentsStackView,
            acceptButton,
            scrollView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.tiny
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        backgroundColor = .systemGray6
        addSubview(mainScrollView)
        mainScrollView.addSubview(initialTextLabel)
        mainScrollView.addSubview(segmentsStackView)
        mainScrollView.addSubview(acceptButton)
        mainScrollView.addSubview(scrollView)
        scrollView.addSubview(documentationStackView)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            initialTextLabel.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Constants.small),
            initialTextLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            segmentsStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            segmentsStackView.topAnchor.constraint(equalTo: initialTextLabel.bottomAnchor, constant: Constants.small),
            segmentsStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Constants.tiny),
            segmentsStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Constants.tiny),
            
            acceptButton.topAnchor.constraint(equalTo: segmentsStackView.bottomAnchor, constant: Constants.medium),
            acceptButton.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: acceptButton.bottomAnchor, constant: Constants.medium),
            scrollView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Constants.tiny),
            scrollView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Constants.tiny),
            scrollView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: max(Constants.screenHeight, Constants.screenWidth) * Multipliers.half),
            
            documentationStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.tiny),
            documentationStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.tiny),
            documentationStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: Multipliers.nineth),
            documentationStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
