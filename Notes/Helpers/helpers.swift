//
//  helpers.swift
//  Notes
//
//  Created by Inyene Etoedia on 04/03/2023.
//

import Foundation
import SwiftUI
import UIKit

extension [NoteModel] {
    var type: NoteType {
        if let firstModel = self.first {
            return firstModel.type
        }
        return .work
    }
}




struct OffSetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect , nextValue: () -> CGRect){
       value = nextValue()
    }
    
}

extension View {
    @ViewBuilder
    func Offset(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect)-> ()) -> some View {
        
        self.overlay{
            GeometryReader{
                let rect = $0.frame(in: .named(coordinateSpace))
                Color.clear
                    .preference(key: OffSetKey.self, value: rect)
                    .onPreferenceChange(OffSetKey.self,perform: completion)
            }
        }
        
    }
}

extension View {
    @ViewBuilder
    func checkAnimationEnd<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View{
        self.modifier(AnimationEndCallBack(for: value, onEnd: completion))
    }
}


fileprivate struct AnimationEndCallBack<Value: VectorArithmetic>: Animatable, ViewModifier{
    
    var animatableData: Value {
        didSet{
            checkIfFinished()
        }
    }
    var endValue: Value
    var onEnd: () -> ()
    
    init(for value: Value, onEnd: @escaping () -> Void) {
        self.animatableData = value
        self.endValue = value
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    private func checkIfFinished(){
        if endValue == animatableData{
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}


