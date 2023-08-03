//
//  create_vm.dart.swift
//  Notes
//
//  Created by Inyene Etoedia on 29/04/2023.
//

import Foundation
import Combine


class CreateNoteViewModel : ObservableObject {
    private var supabaseManager = SupaBaseManager.shared
    @Published var resultState: ResultState<[[Todo]]> = .idle
    @Published var hasError : Bool = false
    
    
    func createNote(title: String, content: String, type: String, id: UUID) async throws -> Void {
        do {
            resultState = .loading
            let todo = Todo(id: id, content: content, title: title, type: type, createdAt: Date.now.description)
           try await supabaseManager.createNotes(todo: todo)
            resultState = .success([[todo]])

        }
        catch {
            print(" error\(error.localizedDescription) ")
            hasError = true
            resultState = .failure(error)
            throw error
        }
       
    }
}
