//
//  ShimmeringButton.swift
//  ShimeringButton
//
//  Created by Artem Gorshkov on 25.06.25.
//

import SwiftUI

struct ShimmeringButton: View {
    @State private var animateGlow = false
    @Binding var isDisabled: Bool
    
    private let action: () -> Void
    private let title: String
    
    init(
        title: String,
        action: @escaping () -> Void,
        isDisabled: Binding<Bool>
    ) {
        self._isDisabled = isDisabled
        self.action = action
        self.title = title
    }
    
    init(
        title: String,
        action: @escaping () -> Void,
        isDisabled: Bool = false
    ) {
        self._isDisabled = .constant(isDisabled)
        self.action = action
        self.title = title
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 64)
                .background(
                    Color(isDisabled ? .gray : .blue)
                        .overlay(
                            shimmeringLine
                                .opacity(isDisabled ? 0 : 1)
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .scaleEffect(animateGlow ? 0.95 : 1.0)
                .id(isDisabled)
                .animation(
                    isDisabled ? nil : .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                    value: animateGlow
                )
        }
        .disabled(isDisabled)
        .onAppear {
            if !isDisabled {
                animateGlow = true
            }
        }
        .onChange(of: isDisabled) { _, newValue in
            animateGlow = !newValue
        }
    }
    
    private var shimmeringLine: some View {
        Color.white.opacity(0.5)
            .rotationEffect(.degrees(20))
            .frame(width: 40, height: 120)
            .blur(radius: 10)
            .offset(
                x: animateGlow ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
            )
            .animation(
                isDisabled ? nil : .linear(duration: 2.0).repeatForever(autoreverses: false),
                value: animateGlow
            )
    }
}

#Preview {
    ShimmeringButton(title: "Shimmering Button", action: {})
}
