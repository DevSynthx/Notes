//
//  ContentView.swift
//  Notes
//
//  Created by Inyene Etoedia on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
   //MARK: STATE VARIABLE
    @State var firstCard: CGFloat = 150
    @State  var firstopacity: CGFloat = 0
    @State  var secondCard: CGFloat = 200
    @State  var secondOpacity: CGFloat = 0
    @State  var scaleText: CGFloat = 0.6
    @State  var test: CGFloat = 0
    @State  var isActive: Bool = false
    @State var displayMain: Bool = false
    var body: some View {
        ZStack {
            
            Start_up_view(firstCard: $firstCard, firstopacity: $firstopacity, secondCard: $secondCard, secondOpacity: $secondOpacity, scaleText: $scaleText, test: $test)
                .opacity(firstCard == 150 ? 0 : 1)
                .onAppear{
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7).delay(0.1)) {
                        scaleText = 1
                    }
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.4)) {
                        firstCard = 0
                        firstopacity = 1
                    }
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.6)) {
                        secondCard = 150
                        secondOpacity = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.6)) {
                            scaleText = 0.6
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.6)) {
                            secondCard = 300
                            secondOpacity = 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.6)) {
                            firstCard = 150
                            firstopacity = 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6).delay(0.9)) {
                            displayMain = true
                        }
                    }
                    
                }
            
            if displayMain {
                MainView()
            }
            
        }
        .background(.black)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NotesViewModel())
    }
}
