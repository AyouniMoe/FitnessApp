//
//  FitnessProfileEditButton.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/12/25.
//

import SwiftUI

struct FitnessProfileEditButton: View {
    @State var title: String
    @State var backgroundColor: Color
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
            
            
        } label: {
            Text(title)
                .padding()
                .frame(maxWidth: 100)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                    )
        }
    }
}

#Preview {
    FitnessProfileEditButton(title: "", backgroundColor: .red) {}
}
