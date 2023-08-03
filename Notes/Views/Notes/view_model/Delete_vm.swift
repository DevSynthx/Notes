//
//  Delete_vm.swift
//  Notes
//
//  Created by Inyene Etoedia on 14/05/2023.
//

import Foundation


class DeleteNoteViewModel: ObservableObject {
    
    private var supabaseManager = SupaBaseManager.shared
    @Published var resultState: ResultState<[[Todo]]> = .idle
    @Published var hasError : Bool = false

    
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
