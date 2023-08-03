//
//  Network_Manager.swift
//  Notes
//
//  Created by Inyene Etoedia on 29/04/2023.
//

import Foundation
import Supabase


protocol SupaBaseService {
    func getNotes () async throws -> [Todo]
    func createNotes (todo: Todo) async throws -> Void
    func updateNotes (todo: Todo) async throws -> [Todo]
    func deleteNote (id: UUID) async throws -> [Todo]
}


class SupaBaseManager : SupaBaseService {
    private var client = SupabaseClient(supabaseURL: .supaBaseUrl(), supabaseKey: Constant.apiKey)
     static let shared = SupaBaseManager()
    
    
    
    func getNotes() async throws -> [Todo] {
        let result = try await client.database.from("Notes").execute()
        do{
            return try JsonMapper().decode(type: [Todo].self, data: result.underlyingResponse.data)
        }
        catch{
            throw ResultState<[Todo]>.failedToDecode(error: error)
        }
    }
    
    func createNotes(todo: Todo) async throws -> Void {
       try await client.database.from("Notes").insert(values: todo).execute()

    }
    
    func updateNotes(todo: Todo) async throws -> [Todo] {
        let result =   try await client.database.from("Notes").update(values: todo).eq(column: "id", value: todo.id).execute()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode([Todo].self, from: result.underlyingResponse.data)
        return decoded
    }
    
    func deleteNote(id: UUID) async throws -> [Todo] {
        let res =  try await client.database.from("Notes").delete().eq(column: "id", value: id).execute()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode([Todo].self, from: res.underlyingResponse.data)
        return decoded
    }
    
    
    
    
    
}
