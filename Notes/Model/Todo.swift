//
//  Todo.swift
//  Notes
//
//  Created by Inyene Etoedia on 22/04/2023.
//

import Foundation


struct Todo : Codable, Hashable, Identifiable {
    var id : UUID
    var content: String
    var  title : String
    var type : String
    var createdAt : String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case content = "content"
        case title = "title"
        case type = "type"
        case createdAt = "createdAt"
    }
    enum TodoType: String, CaseIterable {
        case all = "#All"
        case work = "#Work"
        case personal = "#Personal"
        case sport = "#Sport"
        
        var tabID: String {
            return self.rawValue + self.rawValue.prefix(4)
        }

    }
    
//    mutating func decode (from decoder: Decoder) throws {
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try value.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
//        content =  try value.decodeIfPresent(String.self, forKey: .content) ?? ""
//        title = try value.decodeIfPresent(String.self, forKey: .title) ?? ""
//        type = try value.decodeIfPresent(String.self, forKey: .type) ?? "All"
//        createdAt = try value.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
//
//    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try value.encodeIfPresent(id, forKey: .id)
        try value.encodeIfPresent(content, forKey: .content)
        try value.encodeIfPresent(title, forKey: .title)
        try value.encodeIfPresent(type, forKey: .type)
        try value.encodeIfPresent(createdAt, forKey: .createdAt)
    }
    
//    func encoders(todo: Todo) throws -> Any {
//        
//        guard
//            let data = try? JSONEncoder.encode(todo),
//            let result = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//        else {
//            print("An Error Occured")
//            throw NSError()
//        }
//        
//        return result
//       
//    }
    
    
    
}


struct Social : Codable {
    let instagram_username : String?
    let portfolio_url : String?
    let twitter_username : String?
    let paypal_email : String?

    enum CodingKeys: String, CodingKey {

        case instagram_username = "instagram_username"
        case portfolio_url = "portfolio_url"
        case twitter_username = "twitter_username"
        case paypal_email = "paypal_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        instagram_username = try values.decodeIfPresent(String.self, forKey: .instagram_username)
        portfolio_url = try values.decodeIfPresent(String.self, forKey: .portfolio_url)
        twitter_username = try values.decodeIfPresent(String.self, forKey: .twitter_username)
        paypal_email = try values.decodeIfPresent(String.self, forKey: .paypal_email)
    }
    
    func encode(to encoder: Encoder) throws {
      // 2
      var container = encoder.container(keyedBy: CodingKeys.self)
      // 3
        try container.encode(instagram_username, forKey: .instagram_username)
        try container.encode(portfolio_url, forKey: .portfolio_url)
      // 4
        try container.encode(twitter_username, forKey: .twitter_username)
    }

}
