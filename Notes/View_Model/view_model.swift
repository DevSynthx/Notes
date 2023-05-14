//
//  view_model.swift
//  Notes
//
//  Created by Inyene Etoedia on 11/03/2023.
//

import Foundation
import Realtime
import Supabase

class NoteViewModel: ObservableObject {
    private var client = SupabaseClient(supabaseURL: .supaBaseUrl(), supabaseKey: Constant.apiKey)
   @Published var noteModelType = [[NoteModel]]()
//    @Published var notesModel : [NoteModel] = []
    @Published var todoNote :  [[Todo]] = []
    @Published var result: Result<[[Todo]]>
    @Published private(set) var error : NoteViewModel.NetworkingError?
//    @Published  var valueState : NoteViewModel.ValueState<[[Todo]]>
    @Published var hasError : Bool = false

    
    init(client: SupabaseClient = SupabaseClient(supabaseURL: .supaBaseUrl(), supabaseKey: Constant.apiKey), noteModelType: [[NoteModel]] = [[NoteModel]](), result: Result<[[Todo]]> = .loading, error: NoteViewModel.NetworkingError? = nil, hasError: Bool = false) {
        self.client = client
        self.noteModelType = noteModelType
        self.result = result
        self.error = error
        self.hasError = hasError
                Task{
                try await getNotes()
                }
    }
    

    func getAllNotes(){
       if noteModelType.isEmpty {
        } else{
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
    }
    
    func createNote(title: String, content: String, type: String, id: UUID) async throws -> Todo {
        result = .loading
        let todo = Todo(id: id, content: content, title: title, type: type, createdAt: Date.now.description)
        do {
         try await client.database.from("Notes").insert(values: todo).execute()
         todoNote.removeAll()
         try await getNotes()
            result = .success([[todo]])
            return todo
        }
        catch {
            result = .failure(error)
         throw error
        }
    }
    
    func updateNotes(title: String, content: String, type: String, id: UUID) async throws -> Todo {
        result = .loading
        let todo = Todo(id: id, content: content, title: title, type: type, createdAt: Date.now.description)
        do {
            let res =   try await client.database.from("Notes").update(values: todo).eq(column: "id", value: id).execute()
            
            print("This is response \(String(describing: res.underlyingResponse.data))")
//            print("This is data \(res.underlyingResponse.task)")
         todoNote.removeAll()
         try await getNotes()
          result = .success([[todo]])
            return todo
        }
        catch {
            print(error.localizedDescription)
            result = .failure(error)
         throw error
        }
    }
    
    func deleteNote(id: UUID) async throws -> [Todo]? {
        result = .loading

        do {
            let res =  try await client.database.from("Notes").delete().eq(column: "id", value: id).execute()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([Todo].self, from: res.underlyingResponse.data)
         todoNote.removeAll()
         try await getNotes()
          result = .success([decoded])
            return decoded
        }
        catch {
            result = .failure(error)
         throw error
        }
    }
    
    func getNotes() async throws {
        result = .loading
        do {
            let res =  try await client.database.from("Notes").select().execute()
             let decoder = JSONDecoder()
             decoder.dateDecodingStrategy = .iso8601
             let decoded = try decoder.decode([Todo].self, from: res.underlyingResponse.data)
            if decoded.isEmpty {
                 self.todoNote = []
                self.result = .success(self.todoNote)
            } else{
                  DispatchQueue.main.async { [weak self] in
                      for type in Todo.TodoType.allCases {
                          let products = decoded.filter {$0.type == type.rawValue}
                          self?.todoNote.append(products)
                      }
                      
                      self?.result = .success(self?.todoNote ?? [[]])
                    
                  }
            }

        }
        catch {
            result = .failure(error)
            hasError = result.isFailure            

        }
    }

//    private func encode(todo: Todo) throws -> Encodable {
//        guard
//            let data = try? JSONEncoder().encode(todo),
//            let dictionaryData = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//        else {
//            throw NSError()
//        }
//        return data
//    }
    
    
    
}







extension NoteViewModel{
    enum Result<T: Equatable & Hashable>: LocalizedError {
        case loading
        case success(T)
        case failure(Error)
        case failedToDecode(error: Error)
        
        var value: T? {
            if case .success(let value) = self {
                return value
            }
            return nil
        }
        
        var error: Error? {
            if case .failure(let error) = self {
                return error
            }
            return nil
        }
        
        var isLoading: Bool {
            if case .loading = self {
                return true
            }
            return false
        }
        
        var isSuccess: Bool {
            if case .success = self {
                return true
            }
            return false
        }
        
        var isFailure: Bool {
            if case .failure = self {
                return true
            }
            return false
        }
    }
}


extension NoteViewModel.Result: Equatable {
    static func == (lhs: NoteViewModel.Result<T>, rhs: NoteViewModel.Result<T>) -> Bool {
                switch(lhs, rhs) {
                case (.failedToDecode( let lhs), .failedToDecode(let rhs)):
                    return lhs.localizedDescription == rhs.localizedDescription
                case (.failure(let lhsType), .failure(let rhsType)):
                    return lhsType.localizedDescription == rhsType.localizedDescription
                case (.success(let lhsType), .success(let rhsType)):
                    return lhsType == rhsType
                default:
                    return false
                }
            }
    }

extension NoteViewModel.Result {
    var errorDescription: String? {
        switch self {
        case .failure(let err):
            return "Something went wrong \(err.localizedDescription)"
        case.failedToDecode(let err):
            return "Failed to decode \(err.localizedDescription)"
        case .success(let status):
            return "this is \(status)"
        default:
            return "Unknown"
        }
    }
    
}
    
    
//    static func == (lhs: NoteViewModel.ValueState<T>, rhs: NoteViewModel.ValueState<T>) -> Bool {
//        switch(lhs, rhs) {
//        case (.failed(let lhsType), .failed(let rhsType)):
//            return lhsType.localizedDescription == rhsType.localizedDescription
//        case (.status(let lhsType), .status(let rhsType)):
//            return lhsType == rhsType
//        case (.successful(let lhsType), .successful(let rhsType)):
//            return lhsType == rhsType
//        default:
//            return false
//        }
//    }






extension NoteViewModel {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NoteViewModel.NetworkingError: Equatable {
    
    static func == (lhs: NoteViewModel.NetworkingError, rhs: NoteViewModel.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NoteViewModel.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}


extension NoteViewModel {
    enum ValueState<T: Equatable & Hashable>: LocalizedError {
        case status(Bool = false)
        case successful(T)
        case failed(Error)
        var booleanValue: Bool {
            get {
                if case .status(let value) = self {
                    return value
                }
                return false
            }
            set (newValue){
                    self = .status(newValue)
            }
        }
    }
 
}


extension NoteViewModel.ValueState: Equatable {
    
    static func == (lhs: NoteViewModel.ValueState<T>, rhs: NoteViewModel.ValueState<T>) -> Bool {
        switch(lhs, rhs) {
        case (.failed(let lhsType), .failed(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.status(let lhsType), .status(let rhsType)):
            return lhsType == rhsType
        case (.successful(let lhsType), .successful(let rhsType)):
            return lhsType == rhsType
        default:
            return false
        }
    }
}


extension NoteViewModel.ValueState {
    var errorDescription: String? {
        switch self {
        case .failed(let error):
            return "Something happened. \(error.localizedDescription)"
        case .status(let status):
            return "this is \(status)"
        case .successful(let hash):
            return "Response data is \(hash)"
        }
    }
    
    }
    






