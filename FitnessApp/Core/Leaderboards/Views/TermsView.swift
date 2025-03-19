//
//  TermsView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/8/25.
//

import SwiftUI

struct TermsView: View {
    
    @AppStorage("username") var username: String?
    
    @Binding var showTerms: Bool
    
    @State var name = ""
    @State var acceptedTerms = false
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            TextField("Username", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                    )
            HStack(alignment: .top) {
                Button {
                    withAnimation {
                        acceptedTerms.toggle()
                    }
                } label: {
                    
                    if acceptedTerms {
                        
                        Image(systemName: "square.inset.filled")
                        
                    } else {
                        
                        Image(systemName: "square")
                    }
                }
                
                Text("By checking this box, you agree to our Terms to enter the leaderboard competetion.")
            }
            Spacer()
               
            Button {
                if acceptedTerms && name.count > 2 {
                    username = name
                    showTerms = false
                }
                    
            } label: {
                Text("continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
            
                        )
            }
        }
        .padding(.horizontal)
    }

}

#Preview {
    TermsView(showTerms: .constant(true))
}
