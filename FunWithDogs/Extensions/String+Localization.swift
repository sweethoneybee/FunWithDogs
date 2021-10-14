//
//  String+Localization.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/13.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", comment: "")
    }
}

