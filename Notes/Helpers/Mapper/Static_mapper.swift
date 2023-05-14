//
//  Static_mapper.swift
//  Notes
//
//  Created by Inyene Etoedia on 09/05/2023.
//

import Foundation

struct JsonMapper{
    
    
    func decode<T: Decodable & Hashable>( type: T.Type , data : Data) throws -> T {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
            let decoded = try decoder.decode(type, from: data)
            return decoded
        }
        catch {
            throw error
        }
        
    }
       
    
}
