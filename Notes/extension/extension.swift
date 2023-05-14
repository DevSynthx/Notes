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




func convertDateFormat(inputDate: String) -> String {

     let olDateFormatter = DateFormatter()
     olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

     let oldDate = olDateFormatter.date(from: inputDate)

     let convertDateFormatter = DateFormatter()
     convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

     return convertDateFormatter.string(from: oldDate!)
}

extension String{
    var displayTime: String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let oldDate = olDateFormatter.date(from: self)

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

        return convertDateFormatter.string(from: oldDate!)
    }
}
