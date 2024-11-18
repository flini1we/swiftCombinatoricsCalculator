//
//  ContainerViewController.swift
//  mathHW
//
//  Created by Данил Забинский on 18.11.2024.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case open
        case closed
        
        mutating func `switch`() {
            switch self {
            case .closed:
                self = .open
            case .open:
                self = .closed
            }
        }
    }
    private var menuState = MenuState.closed
    private var titleOfFormula: String!
    private var calculatorContoller: CalculatorScreenController?
    
    private lazy var didTapOnMenu: UIAction = {
        let didTapOnMenu = UIAction { [weak self] _ in
            guard let self else { return }
            switch menuState {
            case .closed:
                calculatorContoller?.hideFields()
                
                navigationController?.navigationBar.isHidden = true
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.homeNavigationController.view.frame.origin.x  = min(self.homeNavigationController.view.bounds.width, self.homeNavigationController.view.bounds.height) * 0.75
                } completion: { [weak self] animationFinishedSuccessful in
                    if animationFinishedSuccessful {
                        self?.menuState.switch()
                    }
                }
            case .open:
                navigationController?.navigationBar.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.homeNavigationController.view.frame.origin.x = 0
                } completion: { [weak self] animationFinishedSuccessful in
                    if animationFinishedSuccessful {
                        self?.menuState.switch()
                    }
                }
            }
        }
        return didTapOnMenu
    }()
    
    private lazy var menuViewController: MenuController = {
        let menu = MenuController()
        return menu
    }()
    
    private lazy var homeNavigationController: UINavigationController = {
        let home = CalculatorScreenController(title: self.titleOfFormula, action: didTapOnMenu)
        calculatorContoller = home
        navigationController?.navigationBar.isHidden = false
        let nc = UINavigationController(rootViewController: home)
        return nc
    }()
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleOfFormula = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
        
        addChild(homeNavigationController)
        view.addSubview(homeNavigationController.view)
        homeNavigationController.didMove(toParent: self)
    }
}
