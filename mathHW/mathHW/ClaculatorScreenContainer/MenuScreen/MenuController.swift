//
//  MenuController.swift
//  mathHW
//
//  Created by Данил Забинский on 17.11.2024.
//

import UIKit

class MenuController: UIViewController {
    private var customView: MenuView {
        view as! MenuView
    }
    private let dataManager = MenuModel()
    private lazy var goBackAction: UIAction = {
        let goBack = UIAction { [weak self] _ in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
            navigationController?.popViewController(animated: true)
        }
        return goBack
    }()
    
    override func loadView() {
        super.loadView()
        self.view = MenuView()
        customView.title.text = dataManager.obtainTitle()
        customView.button.addAction(self.goBackAction, for: .touchUpInside)
    }
}
