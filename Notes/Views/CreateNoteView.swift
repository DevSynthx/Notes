//
//  Details_View.swift
//  Notes
//
//  Created by Inyene Etoedia on 05/03/2023.
//

import SwiftUI

struct CreateNoteView: View {
    @State var title: String = ""
    @State var content: String = ""
    @State var isSelected: NoteType = .personal
    @State private var screenH = UIScreen.main.bounds.height
    @EnvironmentObject var vm : NoteViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    Spacer()
                        .frame(height: 20)
                    HStack{
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                               
                                Text("Back")
                                    .font(.custom(Font.shantellMed, size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 40)
                                .cornerRadius(10)
                            }
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    
                        Spacer()
                        Button {
                            
                            if title.isEmpty || content.isEmpty{
                                return
                            } else{
                                vm.addNote(title: title.trimmingCharacters(in: .whitespacesAndNewlines), content: content, type: isSelected)
                                presentationMode.wrappedValue.dismiss()
                            }

                        } label: {
                            Text("Save")
                                .font(.custom(Font.shantellMed, size: 18))
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                
                    Spacer()
                        .frame(height: 20)
                    TextField("Title", text: $title)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.1).cornerRadius(5))
                        .font(.custom(Font.shantellMed, size: 40))
                    Spacer()
                        .frame(height: 30)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(NoteType.allCases, id: \.hashValue ) {type in
                                 
                                Button {
                                    isSelected = type
                                } label: {
                                    Text(type.rawValue.dropFirst())
                                        .font(.custom(Font.shantellMed, size: 18))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background (Capsule()
                                            .fill(isSelected == type ? Color.yellow : Color.gray.opacity(0.3)))
                                }

                                   
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 30)
                    TextField(
                        "free_form",
                        text: $content,
                        prompt: Text("Type Here..."),
                        axis: .vertical
                        
                    )
                    .lineSpacing(10.0)
                    .lineLimit((Int(screenH) / 35)...)
                    .accentColor(.white)
                    .padding(16)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(Color.white)
                
                }
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment:.topLeading)
            }
        
        }
     
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
