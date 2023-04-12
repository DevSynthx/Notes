//
//  Details_View.swift
//  Notes
//
//  Created by Inyene Etoedia on 09/04/2023.
//

import SwiftUI

struct Details_View: View {
    @EnvironmentObject var vm : NoteViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var note: NoteModel
    var someColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text(note.title)
                    .font(.custom(Font.shantellMed, size: 30))
                    .frame(maxWidth:.infinity, alignment: .leading)
                TextField(
                    "free_form",
                    text: $note.content,
                    prompt: Text("Type Here..."),
                    axis: .vertical

                )
                .lineSpacing(10.0)
                .lineLimit(25...)
                .accentColor(.black)
                .padding(20)
                .background(Color.gray.opacity(0.1))
                .foregroundColor(Color.black)
                .cornerRadius(20)
                Spacer()
                 .frame(height: 40)
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                          .font(.custom(Font.tiltNeon, size: 17))
                          .foregroundColor(.white)
                          .frame(width: 100, height: 50)
                          .background(.blue)
                          .cornerRadius(15)
                    }
                    
                    Spacer()
                    Button {
                        vm.updateNote(title: note.title, content: note.content, id: note.id, type: note.type)
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Confirm")
                          .font(.custom(Font.tiltNeon, size: 17))
                          .foregroundColor(.white)
                          .frame(width: 200, height: 50)
                          .background(.blue)
                          .cornerRadius(15)
                    }
                  
                  
                }
            }
            .padding()
        .edgesIgnoringSafeArea(.all)
        }}
}

struct Details_View_Previews: PreviewProvider {
    static var noteModel = NoteModel(title: "Hello", content: "Hello world", createdAt: Date.now, type: .personal)
    static var previews: some View {
        Details_View(note: noteModel)
    }
}
