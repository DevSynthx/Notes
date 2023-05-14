//
//  Start_up_view.swift
//  Notes
//
//  Created by Inyene Etoedia on 15/04/2023.
//

import SwiftUI

struct Start_up_view: View {
    var someColor = #colorLiteral(red: 1, green: 0.9870046973, blue: 0.9970414042, alpha: 1)
    var otherColor = #colorLiteral(red: 0.623904109, green: 1, blue: 0, alpha: 1)
    @Binding var firstCard: CGFloat
    @Binding  var firstopacity: CGFloat
    @Binding  var secondCard: CGFloat
    @Binding  var secondOpacity: CGFloat
    @Binding  var scaleText: CGFloat
    @Binding  var test: CGFloat
    var body: some View {
            VStack {
                Spacer()
                    .frame(height: 30)
                Text("You suck at taking notes brother, You need us 🙃")
                    .font(.custom(Font.LuckiestGuy, size: 53))
                    .foregroundColor(.white)
                    .scaleEffect(scaleText)
                    .opacity(scaleText == 0.6 ? 0 : 1)
                Spacer()
                    .frame(height: 50)
                Divider()
                    .background(Color.white)
                    .frame( height: 10.0)
                Spacer()
                    .frame(height: 50)
                ZStack {
                    CardWidget(color: Color(someColor), text: "Note sure where this is going 😄 \(test)")
                        .offset(y: firstCard)
                        .opacity(firstopacity)
                        .rotationEffect(Angle(degrees: -10))
                    CardWidget(color: Color(otherColor), text: "How to ship my goods 😜")
                        .offset(x: 90, y: secondCard)
                        .opacity(secondOpacity)
                        .rotationEffect(Angle(degrees: -10))
                        .shadow(radius: 30)
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity, alignment: .top)
            .background(Color.black)
    }
    
    struct Start_up_view_Previews: PreviewProvider {
       
        static var previews: some View {
            Start_up_view(firstCard: .constant(150), firstopacity: .constant(0), secondCard: .constant(200), secondOpacity: .constant(0), scaleText: .constant(0), test: .constant(0))
        }
    }
}
