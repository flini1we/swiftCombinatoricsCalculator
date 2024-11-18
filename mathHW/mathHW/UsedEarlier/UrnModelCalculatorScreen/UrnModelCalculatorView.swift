////
////  UrnModeCalculatorView.swift
////  mathHW
////
////  Created by Данил Забинский on 10.11.2024.
////
//
//import UIKit
//import SwiftMath
//
//class UrnModelCalculatorView: UIView {
//    
//    var hideKeyBoardAction: (() -> Void)?
//    var calculateButtonAction: (() async -> Void)?
//    
//    lazy var resultAlert: UIAlertController = {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        let calculateAgainAction = UIAlertAction(title: "Попробовать еще", style: .default)
//        alert.addAction(calculateAgainAction)
//        return alert
//    }()
//    
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .white
//        scrollView.layer.cornerRadius = Constants.tiny
//        scrollView.isScrollEnabled = true
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//    
//    lazy var formulaLabel: MTMathUILabel = {
//        let label = MTMathUILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = MTFontManager().font(withName: MathFont.latinModernFont.rawValue, size: Fonts.formulasBig)
//        return label
//    }()
//    
//    lazy var enterFirstValueTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = Constants.tiny
//        textField.textAlignment = .center
//        textField.keyboardType = .numbersAndPunctuation
//        textField.backgroundColor = Colors.powderBlue
//        NSLayoutConstraint.activate([
//            textField.heightAnchor.constraint(equalToConstant: Constants.default),
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * 0.85 * Multipliers.half - Constants.tiny / 2),
//        ])
//        let hideKeyboardAction = UIAction { [weak self] _ in
//            self?.hideKeyBoardAction?()
//        }
//        textField.addDoneButton(target: self, action: hideKeyboardAction)
//        return textField
//    }()
//    
//    lazy var enterSecondValueTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = Constants.tiny
//        textField.textAlignment = .center
//        textField.keyboardType = .numbersAndPunctuation
//        textField.backgroundColor = Colors.powderBlue
//        NSLayoutConstraint.activate([
//            textField.heightAnchor.constraint(equalToConstant: Constants.default),
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * 0.85 * Multipliers.half - Constants.tiny / 2),
//        ])
//        let hideKeyboardAction = UIAction { [weak self] _ in
//            self?.hideKeyBoardAction?()
//        }
//        textField.addDoneButton(target: self, action: hideKeyboardAction)
//        return textField
//    }()
//    
//    lazy var enterThirdValueTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = Constants.tiny
//        textField.textAlignment = .center
//        textField.keyboardType = .numbersAndPunctuation
//        textField.backgroundColor = Colors.powderBlue
//        NSLayoutConstraint.activate([
//            textField.heightAnchor.constraint(equalToConstant: Constants.default),
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * 0.85),
//        ])
//        let hideKeyboardAction = UIAction { [weak self] _ in
//            self?.hideKeyBoardAction?()
//        }
//        textField.addDoneButton(target: self, action: hideKeyboardAction)
//        return textField
//    }()
//    
//    lazy var enterFourthValueTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = Constants.tiny
//        textField.textAlignment = .center
//        textField.keyboardType = .numbersAndPunctuation
//        textField.backgroundColor = Colors.powderBlue
//        NSLayoutConstraint.activate([
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * 0.85),
//        ])
//        let hideKeyboardAction = UIAction { [weak self] _ in
//            self?.hideKeyBoardAction?()
//        }
//        textField.addDoneButton(target: self, action: hideKeyboardAction)
//        return textField
//    }()
//    
//    private lazy var enterBothStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [
//            enterFirstValueTextField,
//            enterSecondValueTextField
//        ])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.spacing = Constants.tiny
//        return stack
//    }()
//    
//    private lazy var calculateButton: UIButton = {
//        let action = UIAction { [weak self] _ in
//            guard let self else { return }
//            Task {
//                await self.calculateButtonAction?()
//            }
//        }
//        let button = UIButton(configuration: .filled(), primaryAction: action)
//        button.setTitle("Подсчитать", for: .normal)
//        button.layer.cornerRadius = Constants.tiny
//        button.clipsToBounds = true
//        button.tintColor = Colors.carribianSea
//        button.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            button.heightAnchor.constraint(equalToConstant: Constants.medium),
//            button.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * Multipliers.half),
//        ])
//        return button
//    }()
//    
//    private lazy var textFieldsStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [
//            enterBothStackView,
//            enterThirdValueTextField,
//            enterFourthValueTextField
//        ])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.spacing = Constants.tiny
//        return stack
//    }()
//
//    init() {
//        super.init(frame: .zero)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        setupLayout()
//    }
//    
//    private func setupLayout() {
//        self.backgroundColor = .white
//        addSubview(formulaLabel)
//        addSubview(scrollView)
//        scrollView.addSubview(textFieldsStackView)
//        scrollView.addSubview(calculateButton)
//        NSLayoutConstraint.activate([
//            formulaLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.tiny),
//            formulaLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            scrollView.topAnchor.constraint(equalTo: formulaLabel.bottomAnchor, constant: Constants.medium),
//            scrollView.widthAnchor.constraint(equalToConstant: Constants.screenWidth * 0.9),
//            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.tiny),
//            
//            textFieldsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            textFieldsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.tiny),
//            
//            calculateButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: Constants.default),
//            calculateButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            calculateButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.tiny)
//        ])
//    }
//}
