////
////  CombinatoricsCalculatorView.swift
////  mathHW
////
////  Created by Данил Забинский on 09.11.2024.
////
//
//import UIKit
//import SwiftMath
//
//class CombinatoricsCalculatorView: UIView {
//    
//    var calculateButtonAction: (() async -> Void)?
//    var hideKeyBoardAction: (() -> Void)?
//    
//    lazy var invalidDataAlert: UIAlertController = {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ок", style: .default)
//        alert.addAction(okAction)
//        return alert
//    }()
//    
//    lazy var resultAlert: UIAlertController = {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        let calculateAgainAction = UIAlertAction(title: "Попробовать еще", style: .default)
//        alert.addAction(calculateAgainAction)
//        return alert
//    }()
//    
//    private lazy var scrollView: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.showsVerticalScrollIndicator = false
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        return scroll
//    }()
//    
//    lazy var formulaTitle: MTMathUILabel = {
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
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * Multipliers.threeQuarters),
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
//            textField.widthAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * Multipliers.threeQuarters),
//        ])
//        let hideKeyboardAction = UIAction { [weak self] _ in
//            self?.hideKeyBoardAction?()
//        }
//        textField.addDoneButton(target: self, action: hideKeyboardAction)
//        return textField
//    }()
//    
//    private lazy var textFieldsStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [
//            enterFirstValueTextField,
//            enterSecondValueTextField
//        ])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.spacing = Constants.tiny
//        stack.axis = .vertical
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
//            button.widthAnchor.constraint(equalToConstant: min(Constants.screenWidth, Constants.screenHeight) * Multipliers.half),
//        ])
//        return button
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
//        backgroundColor = .white
//        addSubview(scrollView)
//        scrollView.addSubview(formulaTitle)
//        scrollView.addSubview(textFieldsStackView)
//        scrollView.addSubview(calculateButton)
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//        
//            formulaTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.tiny),
//            formulaTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            
//            textFieldsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            textFieldsStackView.topAnchor.constraint(equalTo: formulaTitle.bottomAnchor, constant: Constants.medium),
//            
//            calculateButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            calculateButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: Constants.default),
//            calculateButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//        ])
//    }
//}
//
///// Extension to updateData
//extension CombinatoricsCalculatorView {
//    func updateButtonTitle(title: String) {
//        calculateButton.setTitle(title, for: .normal)
//    }
//}
