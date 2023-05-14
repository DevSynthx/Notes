//
//  Delete_vm.swift
//  Notes
//
//  Created by Inyene Etoedia on 14/05/2023.
//

import Foundation


class DeleteNoteViewModel: ObservableObject {
    
    private let supabaseManager : SupaBaseManager
    //@Published var notes: NotesViewModel
    @Published var resultState: ResultState<[[Todo]]>
    @Published var hasError : Bool = false
    
    
    init(supabaseManager: SupaBaseManager = SupaBaseManager.shared, resultState: ResultState<[[Todo]]> = .idle){
        self.supabaseManager = supabaseManager
        self.resultState = resultState
    }
    
    func deleteNote(id: UUID) async -> [Todo] {
        do {
            resultState = .loading
            let result = try await supabaseManager.deleteNote(id: id)
            if !result.isEmpty {
                resultState = .success([result])
            }
            return result
        }
        catch {
            hasError = true
            resultState = .failure(error)
         return []
        }
    }

    
   
    
}
