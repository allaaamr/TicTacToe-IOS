//
//  XOButton.swift
//  test3
//
//  Created by Alaa Amr Abdelazeem on 22/08/2022.
//

import SwiftUI
import SwiftUI

struct XOButton: View {
    @Binding var letter: String
    @State private var degrees = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(.orange)
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(.white)
            Text(letter)
                .font(.system(size: 50))
                .bold()
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    withAnimation(.easeIn(duration: 0.45)) {
                        self.degrees -= 180
                    }
                }
        )
    }
}


struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButton(letter: .constant("X"))
    }
}
