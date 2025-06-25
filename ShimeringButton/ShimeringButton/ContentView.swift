//
//  ContentView.swift
//  ShimeringButton
//
//  Created by Artem Gorshkov on 25.06.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isDisabled: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Toggle(isOn: $isDisabled, label: { Text("IsDisabled") })
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 24)
                .padding(.vertical, 40)
            
            ShimmeringButton(
                title: "Shimering Button",
                action: handleTap,
                isDisabled: isDisabled
            )
            .padding(.horizontal, 16)
            
            Spacer()
        }
    }
    
    private func handleTap() {
        print("Button tapped!")
    }
}

#Preview {
    ContentView()
}
