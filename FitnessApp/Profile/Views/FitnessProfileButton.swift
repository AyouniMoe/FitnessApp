//
//  FitnessProfileButton.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/12/25.
//

import SwiftUI

struct FitnessProfileButton: View {
    @State var title: String
    @State var image: String
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: image)
                
                Text(title)
                
            }
            .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FitnessProfileButton(title: "Edit image", image: "square.and.pencil") {}
}

