//
//  CalculatorScreenModel.swift
//  mathHW
//
//  Created by Данил Забинский on 14.11.2024.
//

import Foundation

enum Sections {
    case combinatorics
    case urnModed
}

enum Formulas: String {
    /// Размещение с повторениями
    case placementWithRepetition = "Размещение С повторениями"
    /// Размещение без повторений
    case placementWithoutRepetition = "Размещение Без повторений"
    /// Перестановка с повторениями
    case permutationsWithRepetition = "Перестановка С повторениями"
    /// Перестановка без повторений
    case permutationsWithoutRepetition = "Перестановка Без повторений"
    /// Сочетание с повторениями
    case combinationWithRepetition = "Сочетание С повторениями"
    /// Сочетание без повторений
    case combinationsWithoutRepetition = "Сочетание Без повторений"
    /// Все извлеченные - меченные
    case allMarked = "Все извлеченные - меченные"
    /// Среди извлеченных - r меченных
    case rMarked = "Среди извлеченных - r меченных"
    
    var formulaTitle: String {
        switch self {
        case .allMarked:
            return "Имеются n предметов, среди которых m меченых.\nНаугад извлекаются k предметов (k < m). Вероятность того, что все извлеченные предметы окажутся мечеными, равна: "
        case .rMarked:
            return "Имеются n предметов, среди которых m меченых.\nНаугад извлекаются k предметов (k < m). Вероятность того, что среди извлеченных предметов окажутся r меченых, равна: "
        default:
            return "Ваш результат: "
        }
    }
    
    var getLatixFormula: String {
        switch self {
        case .placementWithRepetition:
            return "\\overline{A}_n^k = n^k"
        case .placementWithoutRepetition:
            return "A^{k}_{n} = \\frac{n!}{(n - k)!}"
        case .permutationsWithRepetition:
            return "P_{n} = \\frac{(\\sum_{i=1}^{k} n_i)!}{\\prod_{i=1}^{k} n_i!}"
        case .permutationsWithoutRepetition:
            return "P_{n} = n!"
        case .combinationWithRepetition:
            return "\\overline{C}^{k}_{n} = C^{k}_{n + k - 1}"
        case .combinationsWithoutRepetition:
            return "C^{k}_{n} = \\frac{n!}{k! \\times (n - k)!}"
        case .allMarked:
            return "P(A) = \\frac{C^{k}_{m}}{C^{k}_{n}}"
        case .rMarked:
            return "P(A) = \\frac{C^{r}_{m} \\times C^{k - r}_{n - m}}{C^{k}_{n}}"
        }
    }
    
    var section: Sections {
        switch self {
        case .allMarked, .rMarked:
            return Sections.urnModed
        default:
            return Sections.combinatorics
        }
    }
}

enum Placeholders: String {
    case missingFormula = "Некорректные данные"
    case nValue = "Введите значение n"
    case kValue = "Введите значение k"
    case mValue = "Введите значение m"
    case rValue = "Введите значение r"
    case multipleValues = "Введите k чисел через запятую"
}

class CalculatorScreenModel {
    let wrongData = "Wrong Data"
    var selectedFormula = "Не выбрано"
    var numberOfFields = 2
    private(set) var shouldHideSecondField: Bool = false
    private(set) var shouldHideThirdField: Bool = false
    private(set) var shouldHideFourthField: Bool = false
    
    func getPlaceholdersFromFormula() -> [String] {
        switch Formulas.init(rawValue: selectedFormula) {
        case .placementWithRepetition, .placementWithoutRepetition, .combinationWithRepetition, .combinationsWithoutRepetition:
            return [Placeholders.nValue.rawValue, Placeholders.kValue.rawValue, "", ""]
        case .permutationsWithRepetition:
            return [Placeholders.multipleValues.rawValue, "", "", ""]
        case .permutationsWithoutRepetition:
            return [Placeholders.nValue.rawValue, "", "", ""]
        case .allMarked:
            return [Placeholders.nValue.rawValue, Placeholders.kValue.rawValue, Placeholders.mValue.rawValue, ""]
        case .rMarked:
            return [Placeholders.nValue.rawValue, Placeholders.kValue.rawValue, Placeholders.mValue.rawValue, Placeholders.rValue.rawValue]
        default:
            return [Placeholders.missingFormula.rawValue]
        }
    }
    
    func hideExtraFields() {
        switch Formulas.init(rawValue: selectedFormula) {
        case .combinationWithRepetition, .combinationsWithoutRepetition, .placementWithRepetition, .placementWithoutRepetition:
            self.shouldHideThirdField = true
            self.shouldHideFourthField = true
        case .permutationsWithRepetition, .permutationsWithoutRepetition:
            self.shouldHideSecondField = true
            self.shouldHideThirdField = true
            self.shouldHideFourthField = true
            self.numberOfFields = 1
        case .allMarked:
            self.shouldHideFourthField = true
            self.numberOfFields = 3
        case .rMarked:
            self.numberOfFields = 4
        default:
            break
        }
    }
    
    func getFormulaFromTitle() -> String {
        return Formulas.init(rawValue: self.selectedFormula)?.getLatixFormula ?? "wrong data"
    }
    
    func getSectionFromTitle() -> Sections? {
        return Formulas.init(rawValue: self.selectedFormula)?.section ?? nil
    }
    
    func obtainInvalidDataAlert() -> String {
        "Некорректные данные"
    }
    
    func obtainResult(n: String, k: String, m: String, r: String) async -> String {
        switch Formulas.init(rawValue: self.selectedFormula) {
        case .placementWithRepetition:
            if let nVal = Int(n), let kVal = Int(k) {
                return await ResultFromFormula.placementWithRepetition(n: nVal, k: kVal)
            }
        case .placementWithoutRepetition:
            if let nVal = Int(n), let kVal = Int(k) {
                return await ResultFromFormula.placementWithoutRepetition(n: nVal, k: kVal)
            }
        case .permutationsWithRepetition:
            let nArray = n.split(separator: ",").filter{ $0 != " " }.map({ Int($0)! })
            return await ResultFromFormula.permutationsWithRepetition(sequence: nArray)
        case .permutationsWithoutRepetition:
            if let nVal = Int(n) {
                return await ResultFromFormula.permutationsWithoutRepetition(n: nVal)
            }
        case .combinationWithRepetition:
            if let nVal = Int(n), let kVal = Int(k) {
                return await ResultFromFormula.combinationWithRepetition(n: nVal, k: kVal)
            }
        case .combinationsWithoutRepetition:
            if let nVal = Int(n), let kVal = Int(k) {
                return await ResultFromFormula.combinationsWithoutRepetition(n: nVal, k: kVal)
            }
        case .allMarked:
            if let nVal = Int(n), let mVal = Int(m), let kVal = Int(k) {
                return await ResultFromFormula.allSelectedAreMarked(n: nVal, k: kVal, m: mVal)
            }
        case .rMarked:
            if let nVal = Int(n), let mVal = Int(m), let kVal = Int(k), let rVal = Int(r) {
                return await ResultFromFormula.rselectedAreMarked(n: nVal, k: kVal, m: mVal, r: rVal)
            }
        default:
            return self.wrongData
        }
        return self.wrongData
    }
}

fileprivate struct ResultFromFormula {
    static func placementWithoutRepetition(n: Int, k: Int) async -> String {
        if n > 20 || k > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if k < 0 || n < 0 {
            return "Ошибка, вы ввели отрицательное число"
        }
        if k > n {
            return "Ошибка, k не может быть больше n"
        } else {
            async let upperValue = factorial(n)
            async let lowerValue = factorial(n - k)
            return "\(await upperValue / lowerValue)"
        }
    }
    
    static func placementWithRepetition(n: Int, k: Int) async -> String {
        if n > 20 || k > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if k < 0 || n < 0 {
            return "Ошибка, вы ввели отрицательное число"
        }
        else {
            return "\(pow(Double(n), Double(k)))"
        }
    }
    static func permutationsWithoutRepetition(n: Int) async -> String {
        if n > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        return "\(await factorial(n))"
    }
    
    static func permutationsWithRepetition(sequence: [Int]) async -> String {
        if sequence.count == 1 {
            return "1.0"
        }
        for elem in sequence {
            if elem > 20 {
                return "Ошибка, Одно из введенных вами значений превышает 20, к сожалению программа не обрабатывает такие большие числа"
            }
        }
        let sum = sequence.reduce(0, +)
        if sum > 20 {
            return "Ошибка, сумма введенных вами значений превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        var devider: Double = 1
        for elem in sequence {
            await devider *= factorial(elem)
        }
        return "\(await factorial(sum) / devider)"
    }
    
    static func combinationsWithoutRepetition(n: Int, k: Int) async -> String {
        if n > 20 || k > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if k < 0 || n < 0 { return "Ошибка, вы ввели отрицательное число" }
        if k > n {
            return "Ошибка, k не может быть больше n"
        } else {
            async let nFact = factorial(n)
            async let kFack = factorial(k)
            async let differenceFact = factorial(n - k)
            return "\(await nFact / (kFack * differenceFact))"
        }
    }
    
    static func combinationWithRepetition(n: Int, k: Int) async -> String {
        if n > 20 || k > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if k < 0 || n < 0 {
            return "Ошибка, вы ввели отрицательное число"
        } else {
            async let upperValue = factorial(n + k - 1)
            async let kFact = factorial(k)
            async let lowerValue = factorial(n - 1)
            print(await upperValue)
            print(await kFact * lowerValue)
            return "\(await upperValue / (kFact * lowerValue))"
        }
    }
    
    static func allSelectedAreMarked(n: Int, k: Int, m: Int) async -> String {
        if n > 20 || k > 20 || m > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if m > n {
            return "Ошибка, m не может быть больше чем n"
        }
        if k > m {
            return "Ошибка, k не может быть больше чем m"
        }
        async let lowerVal = combinationsWithoutRepetition(n: m, k: k)
        async let upperVall = combinationsWithoutRepetition(n: n, k: k)
        
        guard let num1 = await Double(lowerVal) else {
            return await lowerVal
        }
        guard let num2 = await Double(upperVall) else {
            return await upperVall
        }
        return "\(num1 / num2)"
    }
    
    static func rselectedAreMarked(n: Int, k: Int, m: Int, r: Int) async -> String {
        print("n = \(n)")
        print("k = \(k)")
        print("m = \(m)")
        print("r = \(r)")
        if n < 0 || k < 0 || m < 0 || r < 0 {
            return "Ошибка, все значения должны быть неотрицательными"
        }
        if n > 20 || k > 20 || m > 20 || r > 20 {
            return "Ошибка, Введенное вами значение превышает 20, к сожалению программа не обрабатывает такие большие числа"
        }
        if m > n {
            return "Ошибка, количество меченых объектов не может превышать общее количество объектов"
        }
        if r > m {
            return "Ошибка, r не может быть больше m"
        }
        if r > k {
            return "Ошибка, r не может быть больше k"
        }
        if k - r > n - m {
            return "Ошибка, k - r не может быть больше n - m"
        }
        if k > n {
            return "Ошибка, k не может быть больше n"
        }
        async let firstUpper = combinationsWithoutRepetition(n: m, k: r)
        async let secondUpper = combinationsWithoutRepetition(n: n - m, k: k - r)
        async let lower = combinationsWithoutRepetition(n: n, k: k)
        
        guard let firstUpperVal = await Double(firstUpper) else {
            return await firstUpper
        }
        guard let secondUpperVal = await Double(secondUpper) else {
            return await secondUpper
        }
        guard let lowerVal = await Double(lower) else {
            return await lower
        }
        return "\(firstUpperVal * secondUpperVal / lowerVal)"
    }
    
    static func factorial(_ n: Int) async -> Double {
        if n < 0 { return 0 }
        if n == 0 { return 1 }
        
        var result: Double = 1
        for i in 1...min(n, 20) {
            result *= Double(i)
        }
        return result
    }
}
