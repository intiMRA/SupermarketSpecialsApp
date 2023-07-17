//
//  String+Localized.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 31/05/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
