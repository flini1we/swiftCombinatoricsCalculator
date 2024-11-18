////
////  CombinatoricsCalculatorController.swift
////  mathHW
////
////  Created by Данил Забинский on 09.11.2024.
////
//
//import UIKit
//import SwiftMath
//
//class CombinatoricsCalculatorController: UIViewController {
//    
//    private var customView: CombinatoricsCalculatorView {
//        view as! CombinatoricsCalculatorView
//    }
//    
//    private let dataManager = CombinatoricsCalculatorModelData()
//    
//    override func loadView() {
//        super.loadView()
//        view = CombinatoricsCalculatorView()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    init(data: (String, String)) {
//        super.init(nibName: nil, bundle: nil)
//        dataManager.selectedType = data
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        setupData()
//        setupNavigationButton()
//        setupCalculateButtonAction()
//        setupHideKeyboardButton()
//    }
//    
//    private func setupData() {
//        setupFields()
//        
//        let formulaIndex = dataManager.getRawValue()
//        if let combinatoricFormula = Combinatorics.init(rawValue: formulaIndex)?.combinatoricFormula {
//            customView.formulaTitle.latex = combinatoricFormula
//        }
//        
//        if formulaIndex == Combinatorics.permutationsWithRepetition.rawValue {
//            customView.formulaTitle.font = MTFontManager().font(withName: MathFont.latinModernFont.rawValue, size: Fonts.formulasMedium)
//        }
//        
//        if dataManager.selectedType.0 == dataManager.permutationWithRepetitionConstant.0 {
//            dataManager.shouldCheckBothValues = false
//            if dataManager.selectedType.1 == dataManager.permutationWithRepetitionConstant.1 {
//                customView.enterFirstValueTextField.placeholder = dataManager.enterKValuerSeparatedByComma
//            }
//            setHeightAnchor(element: customView.enterSecondValueTextField, constant: 0)
//        } else {
//            setHeightAnchor(element: customView.enterSecondValueTextField, constant: Constants.default)
//        }
//    }
//    
//    private func setupFields() {
//        customView.invalidDataAlert.title = dataManager.wrongDataTitle
//        customView.enterFirstValueTextField.placeholder = dataManager.enterNValue
//        customView.enterSecondValueTextField.placeholder = dataManager.enterKValue
//    }
//    
//    private func setHeightAnchor(element: UIView, constant: CGFloat) {
//        NSLayoutConstraint.activate([
//            element.heightAnchor.constraint(equalToConstant: constant)
//        ])
//    }
//    
//    private func setupNavigationButton() {
//        let showDetailFormula = UIAction { [weak self] _ in
//            guard let self else { return }
//            
//        }
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), primaryAction: showDetailFormula)
//    }
//    
//    private func setupCalculateButtonAction() {
//        customView.calculateButtonAction = { [weak self] in
//            guard let self else { return }
//            if dataManager.isTextValid(val1: customView.enterFirstValueTextField.text!, val2: customView.enterSecondValueTextField.text!) {
//                let firstDigit = customView.enterFirstValueTextField.text!
//                let secondDigit = customView.enterSecondValueTextField.text!
//                
//                let result = await dataManager.obtainResult(firstDigit: firstDigit, secondDigit: secondDigit, selectedType: dataManager.selectedType)
//                customView.resultAlert.title = result.0
//                customView.resultAlert.message = result.1
//                present(customView.resultAlert, animated: true)
//            } else {
//                present(customView.invalidDataAlert, animated: true)
//            }
//        }
//    }
//    
//    private func setupHideKeyboardButton() {
//        customView.hideKeyBoardAction = { [weak self] in
//            guard let self else { return }
//            customView.enterFirstValueTextField.resignFirstResponder()
//            customView.enterSecondValueTextField.resignFirstResponder()
//        }
//    }
//}
