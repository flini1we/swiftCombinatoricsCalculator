//
//  CalculatorScreenView.swift
//  mathHW
//
//  Created by Данил Забинский on 14.11.2024.
//

import UIKit
import SwiftMath

class CalculatorScreenView: UIView {
    
    var hideKeyBoardAction: (() -> Void)?
    
    lazy var invalidDataAlert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        return alert
    }()
    
    lazy var resultAlert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        return alert
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var formulaLabel: MTMathUILabel = {
        let label = MTMathUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MTFontManager().font(withName: MathFont.latinModernFont.rawValue, size: Fonts.formulasBig)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var enterFirstValueField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = Constants.tiny
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.backgroundColor = Colors.powderBlue
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: Constants.default),
        ])
        let closeKBAction = UIAction { [weak self] _ in
            guard let self else { return }
            hideKeyBoardAction?()
        }
        textField.addCloseButton(target: self, action: closeKBAction)
        return textField
    }()
    
    private lazy var enterSecondValueField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = Constants.tiny
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = Colors.powderBlue
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: Constants.default),
        ])
        let closeKBAction = UIAction { [weak self] _ in
            guard let self else { return }
            hideKeyBoardAction?()
        }
        textField.addCloseButton(target: self, action: closeKBAction)
        return textField
    }()
    
    private lazy var enterThirdValueField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = Constants.tiny
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = Colors.powderBlue
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: Constants.default),
        ])
        let closeKBAction = UIAction { [weak self] _ in
            guard let self else { return }
            hideKeyBoardAction?()
        }
        textField.addCloseButton(target: self, action: closeKBAction)
        return textField
    }()
    
    private lazy var enterFourthValueField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = Constants.tiny
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = Colors.powderBlue
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: Constants.default),
        ])
        let closeKBAction = UIAction { [weak self] _ in
            guard let self else { return }
            hideKeyBoardAction?()
        }
        textField.addCloseButton(target: self, action: closeKBAction)
        return textField
    }()
    
    private lazy var firstFields: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            enterFirstValueField,
            enterSecondValueField
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.tiny
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var lastFields: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            enterThirdValueField,
            enterFourthValueField
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = Constants.tiny
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var enterDataFields: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstFields,
            lastFields
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.tiny
        return stack
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.setTitle("Подсчитать", for: .normal)
        button.layer.cornerRadius = Constants.tiny
        button.clipsToBounds = true
        button.tintColor = Colors.carribianSea
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constants.medium),
            button.widthAnchor.constraint(equalToConstant: min(Constants.screenHeight, Constants.screenWidth) * Multipliers.half),
        ])
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(formulaLabel)
        scrollView.addSubview(enterDataFields)
        scrollView.addSubview(calculateButton)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.tiny),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.tiny),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            formulaLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            formulaLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            enterDataFields.topAnchor.constraint(equalTo: formulaLabel.bottomAnchor, constant: Constants.little),
            enterDataFields.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            enterDataFields.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            enterDataFields.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            calculateButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: enterDataFields.bottomAnchor, constant: Constants.medium),
            calculateButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setFormula(formula: String) {
        self.formulaLabel.latex = formula
    }
    
    func hideSecondField(shouldHide: Bool) {
        self.enterSecondValueField.isHidden = shouldHide
    }
    
    func hideThirdField(shouldHide: Bool) {
        self.enterThirdValueField.isHidden = shouldHide
    }
    
    func hideFourthField(shouldHide: Bool) {
        self.enterFourthValueField.isHidden = shouldHide
    }
    
    func setPlaceHolders(placeHolders: [String]) {
        enterFirstValueField.placeholder = placeHolders[0]
        enterSecondValueField.placeholder = placeHolders[1]
        enterThirdValueField.placeholder = placeHolders[2]
        enterFourthValueField.placeholder = placeHolders[3]
    }
    
    func setupLastFields(shouldHide: Bool) {
        if shouldHide {
            enterFourthValueField.removeFromSuperview()
        }
    }
    
    func getInputValues() -> [String] {
        let values = [enterFirstValueField.text ?? "", enterSecondValueField.text ?? "", enterThirdValueField.text ?? "", enterFourthValueField.text ?? ""]
        print(values.count)
        return values
    }
    
    func hideFields() {
        enterFirstValueField.resignFirstResponder()
        enterSecondValueField.resignFirstResponder()
        enterThirdValueField.resignFirstResponder()
        enterFourthValueField.resignFirstResponder()
    }
}

extension UITextField {
    func addCloseButton(target: Any, action: UIAction) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.little))
        let barButton = UIBarButtonItem(title: "Скрыть", primaryAction: action)
        toolBar.setItems([barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
