//
//  LeaderboardView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/7/25.
//

import SwiftUI
import Foundation
import FirebaseFirestore

  
    struct LeaderboardView: View {
        @StateObject var viewModel = LeaderboardViewModel()
        
        @Binding var showTerms: Bool
        
        var body: some View {
            VStack {
                Text("Leaderboard")
                    .font(.largeTitle)
                    .bold()
                HStack {
                    Text("Name")
                        .bold()
                    Spacer()
                    Text("Steps")
                        .bold()
                }
                .padding()
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.leaders) { person in
                        HStack {
                            Text("1.")
                            Text(person.username)
                            Spacer()
                            Text("\(person.count)")
                        }
                        .padding(.horizontal)
                        
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .fullScreenCover(isPresented: $showTerms) {
                TermsView()
            }
            
        }
    }
    
    #Preview {
        LeaderboardView(showTerms: .constant(false))
    }


