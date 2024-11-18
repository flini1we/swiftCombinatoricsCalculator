//
//  CalculatorScreenController.swift
//  mathHW
//
//  Created by Данил Забинский on 14.11.2024.
//

import UIKit

class CalculatorScreenController: UIViewController {
    
    private var customView: CalculatorScreenView {
        view as! CalculatorScreenView
    }
    private let dataManager = CalculatorScreenModel()
    private var openMenuAction: UIAction?
    
    override func loadView() {
        super.loadView()
        view = CalculatorScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.calculateButton.addAction(calculateButtonAction, for: .touchUpInside)
    }
            
    private lazy var calculateButtonAction: UIAction = {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            let values = customView.getInputValues()
            let enterValuesCount = values.filter { $0 != "" }.count
            if enterValuesCount != dataManager.numberOfFields {
                customView.invalidDataAlert.title = dataManager.obtainInvalidDataAlert()
                self.present(customView.invalidDataAlert, animated: true)
            } else {
                Task { [weak self] in
                    guard let self else { return }
                    if let title = Formulas.init(rawValue: dataManager.selectedFormula)?.formulaTitle {
                        let result = await dataManager.obtainResult(n: values[0],
                                                                    k: values[1],
                                                                    m: values[2],
                                                                    r: values[3])
                        if result.contains("Ошибка") {
                            customView.resultAlert.title = "Ошибка"
                        } else {
                            customView.resultAlert.title = title
                        }
                        customView.resultAlert.message = result
                        present(customView.resultAlert, animated: true)
                    }
                }
            }
        }
        return action
    }()
    
    init(title: String, action: UIAction) {
        super.init(nibName: nil, bundle: nil)
        self.openMenuAction = action
        setup(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideFields() {
        customView.hideFields()
    }
    
    private func setup(title: String) {
        setupNavigationBar()
        setupCloseKeyBoardAction()
        setupFields(title: title)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: openMenuAction)
    }
    
    private func setupCloseKeyBoardAction() {
        customView.hideKeyBoardAction = { [weak self] in
            guard let self else { return }
            customView.hideFields()
        }
    }
    
    private func setupFields(title: String) {
        dataManager.selectedFormula = title
        dataManager.hideExtraFields()

        let placeHolders = dataManager.getPlaceholdersFromFormula()
        let formulaLatex = dataManager.getFormulaFromTitle()
        let section = dataManager.getSectionFromTitle()
        
        customView.setFormula(formula: formulaLatex)
        customView.hideSecondField(shouldHide: dataManager.shouldHideSecondField)
        customView.hideThirdField(shouldHide: dataManager.shouldHideThirdField)
        customView.hideFourthField(shouldHide: dataManager.shouldHideFourthField)
        customView.setPlaceHolders(placeHolders: placeHolders)
        
        if section == Sections.urnModed {
            customView.setupLastFields(shouldHide: dataManager.shouldHideFourthField)
        }
    }
}

