//
//  create_vm.dart.swift
//  Notes
//
//  Created by Inyene Etoedia on 29/04/2023.
//

import Foundation


class NotesViewModel : ObservableObject {
    private var supabaseManager = SupaBaseManager.shared
    @Published var todoNote :  [[Todo]] = []
    @Published var resultState: ResultState<[[Todo]]> = .idle
    @Published var hasError : Bool = false
    
    
    init(){
     
        Task{
         await getNotes()
        }
    }
    
    func getNotes() async -> [Todo] {
        do {
            resultState = .loading
            let res = try await supabaseManager.getNotes()
            DispatchQueue.main.async { [weak self] in
                for type in Todo.TodoType.allCases {
                    let products = res.filter {$0.type == type.rawValue}
                    self?.todoNote.append(products)
                }
                self?.resultState = .success(self?.todoNote ?? [[]])
            }
            return res
        }
        catch {
            hasError = true
            resultState = .failure(error)
            return []
        }
       
    }
    
 
}
