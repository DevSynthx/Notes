//
//  CardWidget.swift
//  Notes
//
//  Created by Inyene Etoedia on 15/04/2023.
//

import SwiftUI

struct CardWidget: View {
    let color: Color
    let text: String
    var body: some View {
        Rectangle()
        .frame(width: 270, height: 300)
        .cornerRadius(35)
        .foregroundColor(color)
        .overlay {
            VStack {
                Spacer()
                    .frame(height: 20)
                Text(text)
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 10)
                Text("4th June 2023")
                    .font(.system(size: 18))
                    .foregroundColor(.black.opacity(0.3))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                Text(displayText)
                    .font(.system(size: 20))
                    .foregroundColor(.black.opacity(0.3))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 20)
            }
            .padding([.leading, .trailing], 20)
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct CardWidget_Previews: PreviewProvider {
    static var previews: some View {
        CardWidget(color: .gray, text: "")
    }
}
