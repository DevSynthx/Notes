//
//  ContentView.swift
//  Notes
//
//  Created by Inyene Etoedia on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
    //MARK: STATE VARIABLE
    @State var activeTab : String = "#All"
    @State var isSelected : Bool = false
    @State var screenW = UIScreen.main.bounds.width
    @State var animationProgress: CGFloat = 0
    @State var selectedTodo : SampleModel?
    var someColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
    @Namespace var animation
    @State var modelBaseType : [[SampleModel]] = []
    @State var noteTabs : [String] = ["#All", "#Work", "#Personal", "#Sport"]
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        
                        Text("David Macaulay")
                            .font(.system(size:15))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    HStack {
                        Text("Your Notes")
                            .font(.custom(Font.climateCrisis, size: 50))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 1)
                                    .frame(width: 40, height: 40)
                            }
                        
                    }
                    .padding(.trailing, 30)
                    
                    ScrollViewReader { proxy in
                        VStack {
                            scrollHorizontal(proxy: proxy)
                            
                            Spacer()
                                .frame(height: 30)
                            ScrollView (.vertical, showsIndicators: false) {
                                ForEach(modelBaseType, id:\.self) { model in
                                    ItemSectionBuild(model)
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "CONTENTVIEW")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.horizontal, .vertical], 20)
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                guard modelBaseType.isEmpty else {return}
                for type in ModelType.allCases {
                    let models = sampleModel.filter{$0.type == type}
                    modelBaseType.append(models)
                }
        }
        }
    }
    
    
    @ViewBuilder
    func DetailsView(_ sampleModel: SampleModel) -> some View {
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
    func ItemSectionBuild(_ sampModel: [SampleModel]) -> some View {
        VStack{
            
            if let firstTitle = sampModel.first{
                Text("#\(firstTitle.title)")
                    .font(.custom(Font.shantellReg, size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            Divider()
                .background(Color.white)
                .frame( height: 10.0)
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampModel) { val in
                        GeometryReader { geo in
                            NavigationLink(destination: Details_View(), label: {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 150)
                                    .cornerRadius(5)
                                    .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) - 40) / 10), axis: (x:0.0, y: 20.0, z: -20.0))
                                
                                    .shadow(radius: 10)
                                    .overlay(content: {
                                        VStack {
                                            Text(val.title)
                                                .font(.custom(Font.shantellReg, size: 18))
                                                .foregroundColor(.black)
                                                .frame(maxWidth:.infinity, alignment: .leading)
                                            Text(val.content)
                                                .font(.custom(Font.shantellLit, size: 13))
                                                .foregroundColor(.black)
                                                .frame(maxWidth:.infinity, alignment: .leading)
                                        }
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 10)
                                        .frame(maxHeight:.infinity, alignment: .topLeading)
                                    })
                            })
                              
                        }
                        .padding()
                        .frame(width: 100, height: 190)
                        
                        /* Text(val.title)
                         .foregroundColor(.white)
                         */
                    }
                }
                
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
    
    
    //MARK: TABS
    @ViewBuilder
    func scrollHorizontal(proxy: ScrollViewProxy) -> some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 20) {
                ForEach(ModelType.allCases, id: \.rawValue) { name in
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
                    //                        .contentShape(Rectangle())
                }
            }
        }
        .onChange(of: activeTab) { newVal in
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.4))  {
                proxy.scrollTo(newVal, anchor: .center)
            }
        }
        .checkAnimationEnd(for: animationProgress) {
            ///Reset to default when animation finishes
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
