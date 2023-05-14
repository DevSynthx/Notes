//
//  Details_View.swift
//  Notes
//
//  Created by Inyene Etoedia on 09/04/2023.
//

import SwiftUI

struct Details_View: View {
  
    @Environment(\.dismiss) var dismiss
    @State var note: Todo
    @State var isDelete: Bool = false
    var someColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
    @EnvironmentObject var vm : NotesViewModel
    @StateObject var deleteVm =  DeleteNoteViewModel()
    @StateObject var updateVm =  UpdateNoteViewModel()
    var body: some View {
        
        ScrollView() {
            VStack {
                
                HStack {
                    TextField("Title", text: $note.title)
                        .padding(.horizontal)
                        .accentColor(.black)
    //                    .foregroundColor(.white)
                        .background(Color.gray.opacity(0.1).cornerRadius(5))
                    .font(.custom(Font.shantellMed, size: 40))
                    Spacer()
                        .frame(width: 30)
                    Button {
                        isDelete = true
                    } label: {
                        if ( deleteVm.resultState.isLoading) {
                            ProgressView()
                                .padding(.all, 15)
                                .background(
                                    Color(.gray)
                                    .opacity(0.2)
                                    .cornerRadius(10))
                        } else {
                            Image(systemName: "trash")
                                .font(.system(size: 25))
                                .foregroundColor(.red)
                                .padding(.all, 10)
                                .background(
                                    Color(.gray)
                                    .opacity(0.2)
                                    .cornerRadius(10))
                        }
                    }

                }
                
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
                       dismiss()
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
                        switch vm.resultState {
                        case .loading:
                           return
                        default:
                            Task{
                                 await updateVm.updateNote(title: note.title, content: note.content, type: note.type, id: note.id)
                            }
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        

                        
                    } label: {
                        switch updateVm.resultState {
                        case .loading:
                           ProgressView()
                              .font(.custom(Font.tiltNeon, size: 17))
                              .tint(.white)
                              .frame(width: 200, height: 50)
                              .background(.blue)
                              .cornerRadius(15)
                        default:
                            Text("Confirm")
                              .font(.custom(Font.tiltNeon, size: 17))
                              .foregroundColor(.white)
                              .frame(width: 200, height: 50)
                              .background(.blue)
                              .cornerRadius(15)
                        }
                    }
                  
                  
                }
            }
            .padding()
            .background(Color(.white))
            .alert("Info", isPresented: $isDelete, actions: {
                HStack {
                    Button("Cancel", role: .cancel, action: {})
                    Button("Ok") {
                        Task{
                        await deleteVm.deleteNote(id:note.id)
                           
                        }
                    }
                }
            }, message: {
                Text("Are you sure you want to delete this note 😢😔")
            })
        .edgesIgnoringSafeArea(.all)
        }
        .onChange(of:deleteVm.resultState.isSuccess , perform: { value in
            if value == true {
                Task{
                    vm.todoNote.removeAll()
                    let res = await vm.getNotes()
                    if !res.isEmpty{
                        dismiss()
                    }
                }
            }
        })
        .onChange(of: updateVm.resultState.isSuccess, perform: { newValue in
            if newValue == true {
                Task{
                    vm.todoNote.removeAll()
                    let res = await vm.getNotes()
                    if !res.isEmpty{
                        print("This is success i cant deal with it ")
                        dismiss()
                    }
                }
            }
        })
        .overlay {
            if deleteVm.resultState.isLoading ||  updateVm.resultState.isLoading {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {} // Prevents taps from passing through to the underlying views
                ProgressView()
                    .tint(.blue)
            }
        }
        
    }
        
}

struct Details_View_Previews: PreviewProvider {
    static var noteModel = Todo(id: UUID(), content: "Hello world", title: "Hello", type: "#Work", createdAt: "Date")
    static var previews: some View {
        Details_View( note: noteModel)
            .environmentObject(NotesViewModel())
        
    }
}
