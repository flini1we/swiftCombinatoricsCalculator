//
//  MainScreenModelData.swift
//  mathHW
//
//  Created by Данил Забинский on 11.11.2024.
//

import Foundation
import UIKit

class MainScreenModelData {
    let appTitle = "ProbFinder"
    
    typealias dataField = (UIImage, String, String)
    
    func obtainFirstDataField() -> dataField {
        fistDataField
    }
    private let fistDataField: dataField = (UIImage(systemName: "note.text") ?? UIImage(), "Калькулятор комбинаторики", "Комбинации и вероятности")
    
    func obtainSecondDataField() -> dataField {
        secondDataField
    }
    private let secondDataField: dataField = (UIImage(systemName: "trash.square") ?? UIImage(), "Калькулятор урновых моделей", "Вероятности выборки из урн")
    
    func obtainThirdDataField() ->  dataField {
        thirdDataField
    }
    private let thirdDataField: (UIImage, String, String) = (UIImage(systemName: "point.3.connected.trianglepath.dotted") ?? UIImage(), "Находи закономерности", "Ищи скрытые связи")
    
    var buttonTitles: (String, String) {
        ("Комбинаторика", "Урновые модели")
    }
}
