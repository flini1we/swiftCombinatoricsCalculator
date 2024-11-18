//
//  UrnModelScreenView.swift
//  mathHW
//
//  Created by Данил Забинский on 10.11.2024.
//

import UIKit

class UrnModelScreenView: UIView {
    
    var didTapAtRow: ((UITableView, IndexPath) -> Void)?
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: self.bounds, style: .insetGrouped)
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension UrnModelScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapAtRow?(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        max(Constants.screenHeight, Constants.screenWidth) * Multipliers.threeQuarters / 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = TableSections.allCases[section]
        
        let headerView = UIView()
        headerView.backgroundColor = .systemGroupedBackground
        
        let label = UILabel()
        label.text = sectionType.rawValue
        label.font = UIFont.boldSystemFont(ofSize: Fonts.big)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Constants.tiny),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.medium
    }
}
