//
//  UrnModelModelData.swift
//  mathHW
//
//  Created by Данил Забинский on 10.11.2024.
//

import Foundation
import UIKit

struct Item: Hashable, Identifiable {
    let id: UUID
    let title: String
    let toSection: TableSections
}

class UrnModelModelData {
    func obtainItems() -> [Item] {
        [
            Item(id: UUID(), title: "Все извлеченные - меченные", toSection: .main),
            Item(id: UUID(), title: "Среди извлеченных - r меченных", toSection: .main),
            Item(id: UUID(), title: "Подробнее об урновых моделях", toSection: .documentation),
        ]
    }
    
    func checkIfItemInMainSection(diffableDataSource: UITableViewDiffableDataSource<TableSections, Item>?, indexPath: IndexPath) -> Bool {
        if let item = diffableDataSource?.itemIdentifier(for: indexPath) {
            return item.toSection == TableSections.main
        } else {
            return false
        }
    }
    
    func getItem(diffableDataSource: UITableViewDiffableDataSource<TableSections, Item>?, indexPath: IndexPath) -> Item? {
        let item = diffableDataSource?.itemIdentifier(for: indexPath)
        return item
    }
}
