////
////  CombinatoricsCalculatorModelData.swift
////  mathHW
////
////  Created by Данил Забинский on 09.11.2024.
////
//
//import Foundation
//import UIKit
//
//class CombinatoricsCalculatorModelData {
//    
//    var selectedType: (String, String) = ("", "")
//    var shouldCheckBothValues: Bool = true
//    
//    let permutationWithRepetitionConstant = ("Перестановка", "С повторениями")
//    let enterNValue = "Введите число n"
//    let enterKValuerSeparatedByComma = "Введите k чисел через запятую"
//    let wrongDataTitle = "Некорректные данные"
//    let enterKValue = "Введите число k"
//    
//    func getRawValue() -> Int {
//        switch self.selectedType {
//        case ("Размещение", "С повторениями"): return 0
//        case ("Размещение", "Без повторений"): return 1
//        case ("Перестановка", "С повторениями"): return 2
//        case ("Перестановка", "Без повторений"): return 3
//        case ("Сочетание", "С повторениями"): return 4
//        case ("Сочетание", "Без повторений"): return 5
//        default: return 6
//        }
//    }
//    
//    func obtainResult(firstDigit: String, secondDigit: String, selectedType: (String, String)) async -> (String, String) {
//        let n = self.convertStringToArray(str: firstDigit)
//        let k = secondDigit
//        
//        let result = await self.obtainCalculatedResult(data: selectedType, n: n, k: Int(k) ?? nil)
//        
//        if result.contains("Ошибка") {
//            return ("Упс", result)
//        } else {
//            return (result, "Ваш ответ")
//        }
//    }
//    
//    func isTextValid(val1: String, val2: String) -> Bool {
//        shouldCheckBothValues ? (Int(val1) != nil || isStringIsArray(string: val1)) && Int(val2) != nil : (Int(val1) != nil || isStringIsArray(string: val1))
//    }
//    
//    private func convertStringToArray(str: String) -> [Int] {
//        let str = str.filter { $0 != " " }
//        var array: [Int] = []
//        var currentElem = 0
//        for char in str {
//            if char.isNumber {
//                currentElem *= 10
//                currentElem += char.wholeNumberValue!
//            } else {
//                array += [currentElem]
//                currentElem = 0
//            }
//        }
//        array += [currentElem]
//        return array
//    }
//    
//    private func isStringIsArray(string: String) -> Bool {
//        let splitedString = string.filter { char in
//            char != ","
//        }
//        return Int64(splitedString) != nil || Int(splitedString) != nil
//    }
//    
//    private func obtainCalculatedResult(data: (String, String), n: [Int], k: Int?) async -> String {
//        let nVal = n[0]
//        guard let k else {
//            if data.1 == "Без повторений" {
//                return await permutationsWithoutRepetition(n: nVal)
//            } else {
//                return await permutationsWithRepetition(sequence: n)
//            }
//        }
//        switch data {
//        case ("Размещение", "С повторениями"):
//            return placementWithRepetition(n: nVal, k: k)
//        case ("Размещение", "Без повторений"):
//            return await placementWithoutRepetition(n: nVal, k: k)
//        case ("Сочетание", "Без повторений"):
//            return await combinationsWithoutRepetition(n: nVal, k: k)
//        case ("Сочетание", "С повторениями"):
//            return await combinationWithRepetition(n: nVal, k: k)
//        default:
//            return "No such method"
//        }
//    }
//    
//    func permutationsWithoutRepetition(n: Int) async -> String {
//        return "\(await factorial(n))"
//    }
//    
//    func permutationsWithRepetition(sequence: [Int]) async -> String {
//        let sum = sequence.reduce(0, +)
//        var devider: Double = 1
//        for elem in sequence {
//            await devider *= factorial(elem)
//        }
//        return "\(await factorial(sum) / devider)"
//    }
//    
//    func placementWithoutRepetition(n: Int, k: Int) async -> String {
//        if k < 0 || n < 0 {
//            return "Ошибка, вы ввели отрицательное число"
//        }
//        if k > n {
//            return "Ошибка, k не может быть больше n"
//        } else {
//            async let upperValue = factorial(n)
//            async let lowerValue = factorial(n - k)
//            return "\(await upperValue / lowerValue)"
//        }
//    }
//    
//    func placementWithRepetition(n: Int, k: Int) -> String {
//        if k < 0 || n < 0 {
//            return "Ошибка, вы ввели отрицательное число"
//        }
//        else {
//            return "\(pow(Double(n), Double(k)))"
//        }
//    }
//    
//    func combinationsWithoutRepetition(n: Int, k: Int) async -> String {
//        if k < 0 || n < 0 { return "Ошибка, вы ввели отрицательное число" }
//        if k > n {
//            return "Ошибка, k не может быть больше n"
//        } else {
//            async let nFact = factorial(n)
//            async let kFack = factorial(k)
//            async let differenceFact = factorial(n - k)
//            return "\(await nFact / (kFack * differenceFact))"
//        }
//    }
//    
//    func combinationWithRepetition(n: Int, k: Int) async -> String {
//        if k < 0 || n < 0 {
//            return "Ошибка, вы ввели отрицательное число"
//        } else {
//            async let upperValue = factorial(n + k - 1)
//            async let kFact = factorial(n + k - 1)
//            async let lowerValue = factorial(n - 1)
//            return "\(await upperValue / (kFact * lowerValue))"
//        }
//    }
//    
//    private func factorial(_ n: Int) async -> Double {
//        if n < 0 { return 0 }
//        if n == 0 { return 1 }
//        
//        var result: Double = 1
//        for i in 1...min(n, 20) {
//            result *= Double(i)
//        }
//        return result
//    }
//}
//
