//
//  LeaderboardView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/7/25.
//

import SwiftUI

struct LeaderboardUser: Codable, Identifiable {
    let id = UUID()
    let username: String
    let count: Int
}

class LeaderboardViewModel: ObservableObject {
    var mockData = [
        LeaderboardUser(username: "Ayouni", count: 65636),
        LeaderboardUser(username: "Vivek", count: 6536),
        LeaderboardUser(username: "Sarshad", count: 6563),
        LeaderboardUser(username: "Flavean", count: 5636),
        LeaderboardUser(username: "Melina", count: 6566),
        LeaderboardUser(username: "Lucas", count: 6636),
        LeaderboardUser(username: "Denish", count: 6636),
        LeaderboardUser(username: "Hemaa", count: 6636),
        LeaderboardUser(username: "Bhoomika", count: 6636),
        LeaderboardUser(username: "Madeline", count: 6636),
        LeaderboardUser(username: "Isabella", count: 6636),
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
        .task {
            do {
                try await DatabaseManager.shared.postStepCountUpdateFor(username: "test", count: 1040)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    LeaderboardView(showTerms: .constant(false))
}
