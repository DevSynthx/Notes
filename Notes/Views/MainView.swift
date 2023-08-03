//
//  MainView.swift
//  Notes
//
//  Created by Inyene Etoedia on 15/04/2023.
//

import SwiftUI

struct MainView: View {
    //MARK: STATE VARIABLE
    @State private var activeTab : String = "#All"
    @State private var isSelected : Bool = false
    @State private var screenW = UIScreen.main.bounds.width
    @State private var animationProgress: CGFloat = 0
    @State var selectedTodo : SampleModel?
    //MARK: Animation variable
    @State private var titleText : CGFloat = 40
    @State private var topIcon : CGFloat = 40
    @State private var tabs : Bool = false
    @State var animating: Bool = false
    @State var animationDelay = 0.5
    @State var currentItem : Todo?
    var someColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
    @Namespace var animation
    @State var modelBaseType : [[SampleModel]] = []
//    @StateObject private var vm = NoteViewModel()
    @EnvironmentObject private var newVm : NotesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Label {
                            Text("David Macaulay")
                                .font(.system(size:15))
                                .foregroundColor(.white)
                         
                        } icon: {
                            Image("man")
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 10)
                                .frame(width: 50, height: 50)
                                .background(Color(.green))
                                .clipShape(Circle())
                        }
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                    }
                    .offset(x: topIcon)
                    .opacity(topIcon == 0 ? 1 : 0)
                    
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        Text("Your Notes")
                            .font(.custom(Font.climateCrisis, size: 50))
                            .foregroundColor(.white)
                        Spacer()
                        NavigationLink {
                            CreateNoteView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 1)
                                        .frame(width: 40, height: 40)
                                }
                        }
                    }
                    .padding(.trailing, 30)
                    .offset(x: titleText)
                    .opacity(titleText == 0 ? 1 : 0)
              
                    
                    ScrollViewReader { proxy in
                        VStack {
                            scrollHorizontal(proxy: proxy)
                            Spacer()
                                .frame(height: 40)
                            
                            switch newVm.resultState {
                            case .loading:
                                VStack {
                                    Spacer()
                                        .frame(height: 150)
                                    ProgressView()
                                        .tint(.white)
                                    
                                }
                            case .failure(let err):
                                VStack {
                                    Text("Error\(err.localizedDescription)")
                                }

                            case .success(_):
                                if newVm.todoNote.isEmpty{
                                    VStack {
                                        Spacer()
                                            .frame(height: 100)
                                        Text("create a note 🤪")
                                            .font(.system(size: 23, weight: .light, design: .rounded))
                                            .foregroundColor(.white)
                                            .opacity(animating ? 1 : 0)
                                            .offset(x: animating ? 0 : 10)
                                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.5).delay(0.6), value: animating)
                                          
                                    }

                                } else{
                                    ScrollView (.vertical, showsIndicators: false) {
                                        ForEach(newVm.todoNote, id:\.self) { model in
                                            ItemSectionBuild(model)
                                        }
                                    }
                                    .opacity(titleText == 0 ? 1 : 0)
                                }
                             
                            default:
                               EmptyView()
                            }
                           
                        }
                    }
                    .coordinateSpace(name: "CONTENTVIEW")
                  
        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.horizontal, .vertical], 20)
            }
            .preferredColorScheme(.light)
            .navigationBarHidden(true)
            .onAppear{
    
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5).delay(0.3)) {
                    topIcon = 0
                }
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5).delay(0.6)) {
                    titleText = 0
                    animating = true
                }
            }
            .alert(isPresented: $newVm.hasError, error: newVm.resultState
            ) {
               
            }
//            .environmentObject(NotesViewModel())
        }
        
    }
    
    @ViewBuilder
    func DetailsView(_ sampleModel: NoteModel) -> some View {
        ZStack {
            Color(.green)
            VStack {
                Text("Hello World")
                    .font(.custom(Font.shantellMed, size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
        }
    }
    

    
    // MARK: TODO-SELECTION-BUILD
    @ViewBuilder
    func ItemSectionBuild(_ sampModel: [Todo]) -> some View {
      
        VStack{
            
            if let firstTitle = sampModel.first{
                VStack {
                    Text(firstTitle.type)
                        .font(.custom(Font.shantellReg, size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity, alignment: .leading)
                                Divider()
                                    .background(Color.white)
                                    .frame( height: 10.0)
                }
            }
            
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampModel) { val in
                        GeometryReader { geo in
                            NavigationLink {
                                Details_View(note: val)  .navigationBarBackButtonHidden(true)
                            } label: {
                                detailButton(todo: val, geo: geo)
                            }

                        }
                        .padding()
                        .frame(width: 100, height: 250)
                    }
                }
                .padding(.trailing, 50)
                
            }
            

        }
        /// FOR AUTO SCROLLING  VIA SCROLL PROXY
        .id(sampModel.type)
        .Offset("CONTENTVIEW") { rec in
            let minY = rec.minY
            if(minY < 150 && -minY < (rec.minY / 2) && activeTab != sampModel.type.rawValue) && animationProgress == 0{
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6)) {
                    activeTab = (minY < 150 && -minY < (rec.minY / 2) && activeTab != sampModel.type.rawValue ) ? sampModel.type.rawValue : activeTab
                }
            }
            
        }
        .frame(maxWidth:.infinity, alignment: .trailing)
    }
    
    
    //MARK: DetailButton
    @ViewBuilder
    func detailButton(todo: Todo, geo: GeometryProxy) -> some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: 180, height: 200)
            .cornerRadius(15)
            .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 10), axis: (x:0.0, y: 10.0, z: -10.0))
            .shadow(radius: 10)
            .overlay(content: {
                VStack {
                    Text(todo.title)
                        .font(.custom(Font.alkatra, size: 28))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Spacer()
                        .frame(height: 10)
                    Text(todo.content)
                        .font(.custom(Font.shantellLit, size: 15))
                        .foregroundColor(.gray)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Spacer()
                    Text(todo.createdAt.displayTime)
                        .font(.custom(Font.shantellLit, size: 13))
                        .foregroundColor(.gray)
                        .frame(maxWidth:.infinity, alignment: .center)
                }
                .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 10), axis: (x:0.0, y: 20.0, z: -20.0))
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
                .frame(maxHeight:.infinity, alignment: .topLeading)
            })
    }
    
    //MARK: TABS
    @ViewBuilder
    func scrollHorizontal(proxy: ScrollViewProxy) -> some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 20) {
                ForEach(Todo.TodoType.allCases, id: \.rawValue) { name in
                    Text(name.rawValue)
                        .font(.custom(Font.tiltNeon, size: 15))
                        .foregroundColor(activeTab == name.rawValue ? .black : .white)
                        .padding(15)
                    
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(activeTab == name.rawValue ? .clear : .white, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color(activeTab == name.rawValue ? someColor : .clear))

                            )
                                
                        }
                        .id(name.tabID)
                        .onTapGesture {
                            withAnimation (.interactiveSpring(response: 0.5, dampingFraction: 0.6 )){
                                activeTab = name.rawValue
                                animationProgress = 1.8
                                proxy.scrollTo(name, anchor: .topLeading)
                            }
                        }
                }
            }
            .opacity(animating ? 1 : 0)
            .offset(x: animating ? 0 : 10)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.5).delay(0.6), value: animating)
        }
        .onChange(of: activeTab) { newVal in
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.4))  {
                proxy.scrollTo(newVal, anchor: .center)
            }
        }
        .checkAnimationEnd(for: animationProgress) {
            //Reset to default when animation finishes
            animationProgress = 0.0
        }
    }
    
    /* init(){
     for family in UIFont.familyNames {
     print(family)
     
     for names in UIFont.fontNames(forFamilyName: family){
     print("== \(names)")
     }
     }
     }
     */
    
}

//private var tabView : some View {
//    Text("Your Notes")
//        .font(.custom(Font.climateCrisis, size: 20))
//        .foregroundColor(.white)
//
//}
//private var line : some View {
//    VStack {
//        Divider()
//            .background(Color.white)
//            .frame(width: screenW / 2, height: 10.0)
//    }
//
//}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NotesViewModel())
    }
}
