//
//  extension.swift
//  Notes
//
//  Created by Inyene Etoedia on 09/04/2023.
//

import Foundation


extension Date{
    var displayDate: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
}
