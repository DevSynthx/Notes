//
//  Constants.swift
//  Notes
//
//  Created by Inyene Etoedia on 04/03/2023.
//

import Foundation

struct Font {
static let climateCrisis = "ClimateCrisis-Regular"
static let tiltNeon = "TiltNeon-Regular"
static let shantellReg = "ShantellSans-Regular"
static let shantellMed = "ShantellSans-Medium"
static let shantellLit = "ShantellSans-Light"
static let alkatra = "Alkatra-Medium"
static let josefinSans = "JosefinSans-Bold"
static let LuckiestGuy = "LuckiestGuy-Regular"
}


extension URL {
    static func supaBaseUrl() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "aoyadnlvnakrqtbkfmtt.supabase.co"
        guard let thisUrl = components.url else{return URL(string: "")! }
        return thisUrl
    }
}

struct Constant{
    static let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFveWFkbmx2bmFrcnF0YmtmbXR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIxNTYwNzQsImV4cCI6MTk5NzczMjA3NH0.GgAEQELdFBHTFFra2zn0aJ42aSQ0TXDK4cdemYl4hng"
}

