//
//  Formulas.swift
//  mathHW
//
//  Created by Данил Забинский on 12.11.2024.
//

import Foundation

/// Enum of all combinatorics formulas
enum Combinatorics: Int {
    /// Размещение с повторениями
    case placementWithRepetition = 0
    /// Размещение без повторений
    case placementWithoutRepetition = 1
    /// Перестановка с повторениями
    case permutationsWithRepetition = 2
    /// Перестановка без повторений
    case permutationsWithoutRepetition = 3
    /// Сочетание с повторениями
    case combinationWithRepetition = 4
    /// Сочетание без повторений
    case combinationsWithoutRepetition = 5
    
    var combinatoricFormula: String {
        switch self {
        case .placementWithRepetition:
            return "\\overline{A}_n^k = n^k"
        case .placementWithoutRepetition:
            return "A^{k}_{n} = \\frac{n!}{(n - k)!}"
        case .permutationsWithRepetition:
            return "P_{n}(n_1,...,n_k) = \\frac{(\\sum_{i=1}^{k} n_i)!}{\\prod_{i=1}^{k} (n_i!)}"
        case .permutationsWithoutRepetition:
            return "P_{n} = n!"
        case .combinationWithRepetition:
            return "\\overline{C}^{k}_{n} = C^{k}_{n + k - 1}"
        case .combinationsWithoutRepetition:
            return "C^{k}_{n} = \\frac{n!}{k! \\times (n - k)!}"
        }
    }
}

/// Enum of all urm model probabilities formulas
enum UrnModel {
    case allMarked
    case rMarked
    
    var urnModelFormula: String {
        switch self {
        case .allMarked:
            return "P(A) = \\frac{C^{k}_{m}}{C^{k}_{n}}"
        case .rMarked:
            return "P(A) = \\frac{C^{r}_{m} \\times C^{k - r}_{n - m}}{C^{k}_{n}}"
        }
    }
}



