//
//  Delete_vm.swift
//  Notes
//
//  Created by Inyene Etoedia on 14/05/2023.
//

import Foundation


class UpdateNoteViewModel: ObservableObject {
    
    private let supabaseManager : SupaBaseManager
    @Published var resultState: ResultState<[[Todo]]>
    @Published var hasError : Bool = false
    
    
    init(supabaseManager: SupaBaseManager = SupaBaseManager.shared, resultState: ResultState<[[Todo]]> = .idle){
        self.supabaseManager = supabaseManager
        self.resultState = resultState
    }
    
    func updateNote(title: String, content: String, type: String, id: UUID) async -> [Todo] {
        do {
            resultState = .loading
            let todo = Todo(id: id, content: content, title: title, type: type, createdAt: Date.now.description)
            let res = try await supabaseManager.updateNotes(todo: todo)
            if !res.isEmpty {
                resultState = .success([res])
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
