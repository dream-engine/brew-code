//
//  SectionModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

class SectionModel {
    var headerModel: Any?
    var cellModels: [Any]
    var footerModel: Any?
    
    init(headerModel: Any? = nil, cellModels: [Any], footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}
