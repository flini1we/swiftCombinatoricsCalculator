////
////  UrnModeCalculatorController.swift
////  mathHW
////
////  Created by Данил Забинский on 10.11.2024.
////
//
//import UIKit
//
//class UrnModelCalculatorController: UIViewController {
//    private var customView: UrnModelCalculatorView {
//        view as! UrnModelCalculatorView
//    }
//    private let dataManager = UrnModelCalculatorModelData()
//    
//    init(with item: Item) {
//        dataManager.isScreenContainsFourFields = item.title.contains("r")
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func loadView() {
//        super.loadView()
//        view = UrnModelCalculatorView()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    private func setup() {
//        setupTextFields()
//        setupFormulas()
//        setupHideKeyboardButton()
//        setupCalculateButtonAction()
//    }
//    
//    private func setupTextFields() {
//        setupPlaceholders()
//    }
//    
//    private func setupPlaceholders() {
//        customView.enterFirstValueTextField.placeholder = dataManager.enterNfield
//        customView.enterSecondValueTextField.placeholder = dataManager.enterMfield
//        customView.enterThirdValueTextField.placeholder = dataManager.enterKfield
//        customView.enterFourthValueTextField.placeholder = dataManager.enterRfield
//    }
//    
//    private func setupFormulas() {
//        if dataManager.isScreenContainsFourFields {
//            customView.formulaLabel.latex = UrnModel.rMarked.urnModelFormula
//            setupHeightAnchor(element: customView.enterFourthValueTextField, constant: Constants.default)
//        } else {
//            customView.formulaLabel.latex = UrnModel.allMarked.urnModelFormula
//            setupHeightAnchor(element: customView.enterFourthValueTextField, constant: 0)
//        }
//    }
//    
//    private func setupHeightAnchor(element: UIView, constant: CGFloat) {
//        NSLayoutConstraint.activate([
//            element.heightAnchor.constraint(equalToConstant: constant)
//        ])
//    }
//    
//    private func setupHideKeyboardButton() {
//        customView.hideKeyBoardAction = { [weak self] in
//            guard let self else { return }
//            hideAllKeyboards()
//        }
//    }
//    
//    private func setupCalculateButtonAction() {
//        customView.calculateButtonAction = { [weak self] in
//            guard let self else { return }
//            let n = customView.enterFirstValueTextField.text!,
//                m = customView.enterSecondValueTextField.text!,
//                k = customView.enterThirdValueTextField.text!,
//                r = customView.enterFourthValueTextField.text!
//            
//            let result = await self.dataManager.obtainResult(n: n, m: m, k: k, r: r)
//            customView.resultAlert.title = result
//            present(customView.resultAlert, animated: true)
//        }
//    }
//    
//    private func hideAllKeyboards() {
//        customView.enterFirstValueTextField.resignFirstResponder()
//        customView.enterSecondValueTextField.resignFirstResponder()
//        customView.enterThirdValueTextField.resignFirstResponder()
//        customView.enterFourthValueTextField.resignFirstResponder()
//    }
//}
