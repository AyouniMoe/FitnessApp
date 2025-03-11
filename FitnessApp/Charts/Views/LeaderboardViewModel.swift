//
//  LeaderboardViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

import Foundation

class LeaderboardViewModel: ObservableObject {
    
    @Published var leaders = [LeaderboardUser]()
    
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
    
    init() {
        Task {
            do {
                
                try await postStepCountForUser(username: "xcode", count: 123)
                let result = try await fetchLeaderboards()
                DispatchQueue.main.async {
                    self.leaders = result.top10
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
        struct LeaderboardResult {
            let user: LeaderboardUser?
            let top10: [LeaderboardUser]
            
        }
        
        func fetchLeaderboards() async throws -> LeaderboardResult {
            let leaders = try await DatabaseManager.shared.fetchLeaderboards()
            let top10 = Array(leaders.sorted(by: { $0.count > $1.count }).prefix(10))
            let username = UserDefaults.standard.string(forKey: "username")
            
            if let username = username {
                let user = leaders.first(where: { $0.username == username})
                return LeaderboardResult(user: user, top10: top10)
            } else {
                return LeaderboardResult(user: nil, top10: top10)
            }
            
        }
    }
    func postStepCountForUser(username: String, count: Int) async throws {
        try await DatabaseManager.shared.postStepCountUpdateForUser(leader:
                LeaderboardUser(username: username, count: count))
    }
