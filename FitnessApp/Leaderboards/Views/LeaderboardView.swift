//
//  LeaderboardView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/7/25.
//

import SwiftUI

struct LeaderboardUser: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let usename: String
    let count: Int
}

class LeaderboardViewModel: ObservableObject {
    var mockData = [
        LeaderboardUser(id: 0, createdAt: "", usename: "Ayouni", count: 65636),
        LeaderboardUser(id: 1, createdAt: "", usename: "Vivek", count: 6536),
        LeaderboardUser(id: 2, createdAt: "", usename: "Sarshad", count: 6563),
        LeaderboardUser(id: 3, createdAt: "", usename: "Flavean", count: 5636),
        LeaderboardUser(id: 4, createdAt: "", usename: "Melina", count: 6566),
        LeaderboardUser(id: 5, createdAt: "", usename: "Lucas", count: 6636),
        LeaderboardUser(id: 6, createdAt: "", usename: "Denish", count: 6636),
        LeaderboardUser(id: 7, createdAt: "", usename: "Hemaa", count: 6636),
        LeaderboardUser(id: 8, createdAt: "", usename: "Bhoomika", count: 6636),
        LeaderboardUser(id: 9, createdAt: "", usename: "Madeline", count: 6636),
        LeaderboardUser(id: 10, createdAt: "", usename: "Isabella", count: 6636),
    ]
}
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
                ForEach(viewModel.mockData) { person in
                    HStack {
                        Text("\(person.id).")
                        Text(person.usename)
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
