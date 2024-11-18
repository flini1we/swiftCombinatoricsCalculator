//
//  TableViewDiffableDataSource.swift
//  mathHW
//
//  Created by Данил Забинский on 10.11.2024.
//

import Foundation
import UIKit

enum TableSections: String, CaseIterable {
    case main = "Калькулятор урновых моделей"
    case documentation = "Документация"
}

class TableViewDiffableDataSource {
    var diffableDataSource: UITableViewDiffableDataSource<TableSections, Item>?
    
    init(with tableView: UITableView) {
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView,
        cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = .systemFont(ofSize: 18)
            cell.backgroundColor = Colors.powderBlue
            return cell
        })
    }
}
