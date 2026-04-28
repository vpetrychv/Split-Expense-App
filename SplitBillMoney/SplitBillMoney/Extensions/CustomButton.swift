//
//  CustomButton.swift
//  MoneySplitBill
//
//  Created by Vasyl Petrych on 10/04/2026.
//

import SwiftUI

import SwiftUI

struct CustomButton: View {
    
    var action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            Label("See Result", systemImage: "equal.circle.fill")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(Color.white)
                .background(.blue.gradient)
                .cornerRadius(40)
                .padding(.horizontal, 20)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .opacity(isPressed ? 0.9 : 1.0)
        }
        .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
        .animation(.easeInOut(duration: 0.2), value: isPressed)
    }
}

#Preview {
    CustomButton(action: {})
}
