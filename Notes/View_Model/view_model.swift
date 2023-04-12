//
//  view_model.swift
//  Notes
//
//  Created by Inyene Etoedia on 11/03/2023.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    @Published var noteModelType = [[NoteModel]]()
    @Published var notesModel : [NoteModel] = []
    
    
    
    func getAllNotes(){
       if notesModel.isEmpty {
//           self.notesModel = []
        } else{
//            for type in NoteType.allCases {
//            let models = notesModel.filter{$0.type == type}
//                noteModelType.removeAll()
//                print(models)
//                noteModelType.append(models)
//            }
        }
        
    }
    
    func addNote(title: String, content: String, type: NoteType){
        //MARK: CHECK THE 2 DIMMENSIONAL LIST IF IT CONTAINS THAT TYPE
            let filteredNumbers = noteModelType.first{$0.contains { item in
                return item.type == type
            }}
      //MARK: GET THE INDEX OF SELECTED TYPE IN THE 2 DIMENSIONAL LIST
        let indexx = noteModelType.firstIndex{$0.contains { yes in
            return yes.type == type
        }}
        
        print("This is the index of : \(indexx ?? 6)")
        print("This is the type of : \(filteredNumbers ?? []) of \(type)")
        if (filteredNumbers != nil) == true {
            noteModelType[indexx ?? 0].insert(NoteModel(title: title, content: content, createdAt: Date.now, type: type), at: 0)
                print("STARTS HERE ------------------------->")
                print(noteModelType)
        }
        else{
           noteModelType.append([NoteModel(title: title, content: content,createdAt: Date.now, type: type)])

        }
    }
    
    
    func updateNote(title: String, content: String, id: UUID, type: NoteType){
        //MARK: CHECK THE 2 DIMMENSIONAL LIST IF IT CONTAINS THAT TYPE
        let indexx = noteModelType.firstIndex{$0.contains { yes in
            return yes.type == type
        }}
        //MARK: GET THE OBJECT THAT IS EQUALS TO THE UUID 
        let twoD =  noteModelType[indexx ?? 0].firstIndex{$0.id == id}
        
        if (twoD != nil) || (indexx != nil ){
            noteModelType[indexx ?? 0][twoD ?? 0] = NoteModel(title: title, content: content,createdAt: Date.now, type: type)

        }
        
        
    
        
       
        

        
      
        
       // noteModelType[index] = NoteModel(title: title, content: content,createdAt: Date.now)
        
    }
    
    
    
}
