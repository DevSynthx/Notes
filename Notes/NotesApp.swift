//
//  NotesApp.swift
//  Notes
//
//  Created by Inyene Etoedia on 26/02/2023.
//

import SwiftUI

@main
struct NotesApp: App {
    @StateObject var notesViewModel = NotesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notesViewModel)
        }
    }
}
