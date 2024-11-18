//
//  ModalDocumentationVIewController.swift
//  mathHW
//
//  Created by Данил Забинский on 11.11.2024.
//

import UIKit

class ModalDocumentationVIewController: UIViewController {
    private var customView: ModalDocumentationView {
        view as! ModalDocumentationView
    }
    private let modalDocumentationModalData = ModalDocumentationModalData()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    override func loadView() {
        super.loadView()
        view = ModalDocumentationView()
        customView.backgroundColor = Colors.powderBlue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupData() {
        navigationItem.title = modalDocumentationModalData.obtainTitle()
        customView.titleView.image = modalDocumentationModalData.obtainImage()
        customView.subTitleLabel.text = modalDocumentationModalData.obtainText()
    }
}
