//
//  Sample_Model.swift
//  Notes
//
//  Created by Inyene Etoedia on 04/03/2023.
//

import Foundation


struct SampleModel: Identifiable, Hashable{
    var id = UUID()
    var title : String
    var content: String
    var type : ModelType
}

enum ModelType: String, CaseIterable {
    case all = "#All"
    case work = "#Work"
    case personal = "#Personal"
    case sport = "#Sport"
    
    var tabID: String {
        return self.rawValue + self.rawValue.prefix(4)
    }
}


struct NoteModel: Identifiable, Hashable {
    var id = UUID()
    var title : String
    var content: String
    var createdAt: Date
    var type : NoteType
}

enum NoteType: String, CaseIterable {
    case all = "#All"
    case work = "#Work"
    case personal = "#Personal"
    case sport = "#Sport"
    
    var tabID: String {
        return self.rawValue + self.rawValue.prefix(4)
    }

}


    enum Stuff: String, CaseIterable {
        case first = "First"
        case second = "Second"
        case third = "Third"
        case forth = "Forth"
    }


var displayText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."

//
//
//var sampleModel: [SampleModel] = [
//
//    SampleModel(title: "All", content: "This is COntent 1", type: .all),
//    SampleModel(title: "All", content: "This is COntent 2",type: .all),
//    SampleModel(title: "All", content: "This is COntent 3", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//    SampleModel(title: "All", content: "This is COntent 4", type: .all),
//
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Work", content: "This is COntent 4", type: .work),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Personal", content: "This is COntent 4", type: .personal),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//    SampleModel(title: "Sport", content: "This is COntent 4", type: .sport),
//
//
//
//]
