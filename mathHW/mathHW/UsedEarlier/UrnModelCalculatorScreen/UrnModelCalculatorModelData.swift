////
////  UrnModelCalculatorModelData.swift
////  mathHW
////
////  Created by Данил Забинский on 10.11.2024.
////
//
//import Foundation
//
//class UrnModelCalculatorModelData {
//    var isScreenContainsFourFields: Bool = false
//                                    
//    let enterNfield = "Введите число n"
//    let enterMfield = "Введите число m"
//    let enterKfield = "Введите число k"
//    let enterRfield = "Введите число r"
//    let warningTitle = "Ошибка!\nНекорректные данные"
//    let urnModelCalculatorTitle = "Имеются n предметов, среди которых m меченых.\n"
//    let rSelectedAreMarkedTitle = "Наугад извлекаются k предметов (k < m). Вероятность того, что среди извлеченных предметов окажутся r меченых, равна: "
//    let allSelectedAreMarkedTitle = "Наугад извлекаются k предметов (k < m). Вероятность того, что все извлеченные предметы окажутся мечеными, равна: "
//    
//    func isTextValid(val1: String, val2: String, val3: String, val4: String) -> Bool {
//        let state = Int(val1) != nil && Int(val2) != nil && Int(val3) != nil
//        if self.isScreenContainsFourFields {
//            return state && Int(val4) != nil
//        } else {
//            return state
//        }
//    }
//    
//    func obtainResult(n: String, m: String, k: String, r: String) async -> String {
//        if self.isTextValid(val1: n, val2: m, val3: k, val4: r) {
//            let n = Int(n)!, m = Int(m)!, k = Int(k)!
//            var result: String = "Empty data",
//                selectedConstant = "Empty data"
//            if self.isScreenContainsFourFields {
//                let r = Int(r)!
//                selectedConstant = rSelectedAreMarkedTitle
//                result = await self.rselectedAreHighlighted(n: n, m: m, k: k, r: r)
//            } else {
//                selectedConstant = allSelectedAreMarkedTitle
//                result = await self.allSelectedAreHighlighted(n: n, m: m, k: k)
//            }
//            if result.contains("Ошибка,") {
//                return "Упс!\n" + result
//            } else {
//                return urnModelCalculatorTitle + selectedConstant + result
//            }
//        } else {
//            return warningTitle
//        }
//    }
//    
//    private func allSelectedAreHighlighted(n: Int, m: Int, k: Int) async -> String {
//        if m > n {
//            return "Ошибка, m не может быть больше чем n"
//        }
//        if k > m {
//            return "Ошибка, k не может быть больше чем m"
//        }
//        async let lowerVal = combinationLower(m: m, k: k)
//        async let upperVall = combinationHigher(n: n, k: k)
//        
//        guard let num1 = await Double(lowerVal) else {
//            return await lowerVal
//        }
//        guard let num2 = await Double(upperVall) else {
//            return await upperVall
//        }
//        return "\(num1 / num2)"
//    }
//    
//    private func rselectedAreHighlighted(n: Int, m: Int, k: Int, r: Int) async -> String {
//        async let firstUpper = combinationRM(m: m, r: r)
//        async let secondUpper = combinationKRcrossNM(k: k, r: r, n: n, m: m)
//        async let lower = combinationHigher(n: n, k: k)
//        
//        guard let firstUpperVal = await Double(firstUpper) else {
//            return await firstUpper
//        }
//        guard let secondUpperVal = await Double(secondUpper) else {
//            return await secondUpper
//        }
//        guard let lowerVal = await Double(lower) else {
//            return await lower
//        }
//
//        return "\(firstUpperVal * secondUpperVal / lowerVal)"
//    }
//    
//    private func combinationRM(m: Int, r: Int) async -> String {
//        if r < 0 || m < 0 { return "Ошибка, вы ввели отрицательное число" }
//        if r > m {
//            return "Ошибка, k не может быть больше m"
//        } else {
//            async let mFact = factorial(m)
//            async let rFact = factorial(r)
//            async let factorialOfDifference = factorial(m - r)
//            return "\(await mFact / (rFact * factorialOfDifference))"
//        }
//    }
//    
//    private func combinationKRcrossNM(k: Int, r: Int, n: Int, m: Int) async -> String {
//        let upper = k - r
//        let lower = n - m
//        if upper < 0 || lower < 0 { return "Ошибка, где-то в формуле отрицательное число. K не может быть больше чем r" }
//        if upper > lower {
//            return "Ошибка, k - r не может быть больше n - m"
//        } else {
//            async let lowerFact = factorial(lower)
//            async let upperFact = factorial(upper)
//            async let factOfDifference = factorial(lower - upper)
//            return "\(await lowerFact / (upperFact * factOfDifference))"
//        }
//    }
//    
//    private func combinationLower(m: Int, k: Int) async -> String {
//        if k < 0 || m < 0 { return "Ошибка, вы ввели отрицательное число" }
//        if k > m {
//            return "Ошибка, k не может быть больше m"
//        } else {
//            async let mFact = factorial(m)
//            async let kFact = factorial(k)
//            async let factOfDifference = factorial(m - k)
//            return "\(await mFact / (kFact * factOfDifference))"
//        }
//    }
//    
//    private func combinationHigher(n: Int, k: Int) async -> String {
//        if k < 0 || n < 0 { return "Ошибка, вы ввели отрицательное число" }
//        if k > n {
//            return "Ошибка, k не может быть больше n"
//        } else {
//            async let nFact = factorial(n)
//            async let kFact = factorial(k)
//            async let factOfDifference = factorial(n - k)
//            return "\(await nFact / (kFact * factOfDifference))"
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
