//
//  CombinatoricsViewController.swift
//  mathHW
//
//  Created by Данил Забинский on 07.11.2024.
//

import UIKit
import WebKit

class CombinatoricsController: UIViewController {
    private var customView: CombinatoricsView {
        view as! CombinatoricsView
    }
    private let dataManager = CombinatoricsModelData()
    
    override func loadView() {
        super.loadView()
        view = CombinatoricsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupLabels()
        setupSegmentConstrolls()
        setSegmentControlsActions()
        setupAcceptButtonAction()
    }
    
    private func setupLabels() {
        customView.initialTextLabel.text = dataManager.titleLabelText
        customView.documentationTitle.text = dataManager.documentationLabel
        customView.documentationLabel.text = dataManager.obtainDocumentation()
    }
    
    private func setupSegmentConstrolls() {
        setSegment(segment: customView.typesSegmentControl, with: dataManager.selectionTypes)
        setSegment(segment: customView.repetitionSegmentControl, with: dataManager.selectionRepetition)
    }
    
    private func setSegment(segment: UISegmentedControl, with items: [String]) {
        segment.removeAllSegments()
        for (index, item) in items.enumerated() {
            segment.insertSegment(withTitle: item, at: index, animated: false)
        }
    }
    
    private func setSegmentControlsActions() {
        customView.typesSegmentControlAction = { [weak self] in
            guard let self else { return }
            dataManager.selectedType.0 = dataManager.selectionTypes[customView.typesSegmentControl.selectedSegmentIndex]
        }
        customView.repetitionSegmentControlAction = { [weak self] in
            guard let self else { return }
            dataManager.selectedType.1 = dataManager.selectionRepetition[customView.repetitionSegmentControl.selectedSegmentIndex]
        }
    }
    
    private func setupAcceptButtonAction() {
        customView.acceptButtonAction = { [weak self] in
            guard let self else { return }
            if !dataManager.contains(val: dataManager.noSelection) {
                let calculatorScreen = ContainerViewController(title: dataManager.obtatinSelectedType())
                navigationController?.pushViewController(calculatorScreen, animated: true)
            } else {
                customView.invalidDataAlert.title = dataManager.invalidDataMessage.0
                customView.invalidDataAlert.message = dataManager.invalidDataMessage.1
                present(customView.invalidDataAlert, animated: true)
            }
        }
    }
}


