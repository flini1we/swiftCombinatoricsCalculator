//
//  ViewController.swift
//  mathHW
//
//  Created by Данил Забинский on 07.11.2024.
//

import UIKit

class MainScreenController: UIViewController {
    var customView: MainScreenView {
        self.view as! MainScreenView
    }
    private let dataManager = MainScreenModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = MainScreenView()
        setup()
    }
    
    private func setup() {
        setupNavigationItem()
        setupButtons()
        setupStackViewData()
    }
    
    private func setupNavigationItem() {
        customView.backgroundColor = .white
        navigationItem.title = dataManager.appTitle
    }
    
    private func setupButtons() {
        setupCombinatoricCalculatorButton()
        setupUrnCalculatorButton()
    }
    
    private func setupCombinatoricCalculatorButton() {
        customView.combinatoricsButton.setTitle(dataManager.buttonTitles.0, for: .normal)
        customView.combinatoricsButtonTapped = { [weak self] in
            guard let self else { return }
            navigationController?.pushViewController(CombinatoricsController(), animated: true)
        }
    }
    
    private func setupUrnCalculatorButton() {
        customView.urnModelButton.setTitle(dataManager.buttonTitles.1, for: .normal)
        customView.urnModelButtonTapped = { [weak self] in
            guard let self else { return }
            navigationController?.pushViewController(UrnModelScreenController(), animated: true)
        }
    }
    
    private func setupStackViewData() {
        let firstStackViewData = dataManager.obtainFirstDataField()
        customView.firstStackViewImage.image = firstStackViewData.0
        customView.firstStackViewLabel.text = firstStackViewData.1
        customView.firstStackViewSubLabel.text = firstStackViewData.2
        
        let secondStackViewData = dataManager.obtainSecondDataField()
        customView.secondStackViewImage.image = secondStackViewData.0
        customView.secondStackViewLabel.text = secondStackViewData.1
        customView.secondStackViewSubLabel.text = secondStackViewData.2
        
        let thirdStackViewData = dataManager.obtainThirdDataField()
        customView.thirdStackViewImage.image = thirdStackViewData.0
        customView.thirdStackViewLabel.text = thirdStackViewData.1
        customView.thirdStackViewSubLabel.text = thirdStackViewData.2
    }
}
