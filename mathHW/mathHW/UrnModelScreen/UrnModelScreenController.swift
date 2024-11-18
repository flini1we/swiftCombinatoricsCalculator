//
//  UrnModelScreenController.swift
//  mathHW
//
//  Created by Данил Забинский on 10.11.2024.
//

import UIKit

class UrnModelScreenController: UIViewController {
    private var customView: UrnModelScreenView {
        view as! UrnModelScreenView
    }
    private let dataManager = UrnModelModelData()
    
    private var dataSource: TableViewDiffableDataSource?
    
    private lazy var items = dataManager.obtainItems()
    
    override func loadView() {
        super.loadView()
        view = UrnModelScreenView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupDataSource()
        setupAction()
    }
    
    private func setupDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<TableSections, Item>()
        
        dataSource = TableViewDiffableDataSource(with: customView.tableView)
        for section in TableSections.allCases {
            snapshot.appendSections([section])
            let itemsInSection = items.filter { $0.toSection == section }
            snapshot.appendItems(itemsInSection, toSection: section)
        }
        dataSource?.diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupAction() {
        customView.didTapAtRow = { [weak self] tableView, indexPath in
            guard let self else { return }
            let isMainSection = dataManager.checkIfItemInMainSection(diffableDataSource: dataSource?.diffableDataSource, indexPath: indexPath)
            if isMainSection {
                guard let item = dataManager.getItem(diffableDataSource: dataSource?.diffableDataSource, indexPath: indexPath) else { return }
                let calculatorScreen = ContainerViewController(title: item.title)
                navigationController?.pushViewController(calculatorScreen, animated: true)
            } else {
                let modalDocumentationNavigationController = UINavigationController(rootViewController: ModalDocumentationVIewController())
                self.present(modalDocumentationNavigationController, animated: true)
            }
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
