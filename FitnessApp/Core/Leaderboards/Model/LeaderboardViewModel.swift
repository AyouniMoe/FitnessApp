//
//  LeaderboardViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

import Foundation

@Observable

class LeaderboardViewModel {
    
    //    var selectedMonth = 0
    //    var selectedDate = Date()
    //    var fetchedMonths: Set<String> = []
    //
    //    var workouts: [Workout] = []
    //    var currentMonthsWorkouts = [Workout]()
    //
    var leaderResult = LeaderboardResult(user: nil, top10: [])
    var showAlert = false
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
    
    let databaseManager = DatabaseManager.shared
    let healthManager = HealthManager.shared
    
    init() {
        setupLeaderboardData()
    }
    
    func setupLeaderboardData() {
        Task {
            do {
                try await postStepCountForUser()
                let result = try await fetchLeaderboards()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.leaderResult = result
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.showAlert = true
                }
            }
        }
        
    }
    
    struct LeaderboardResult {
        let user: LeaderboardUser?
        let top10: [LeaderboardUser]
        
    }
    
    private func fetchLeaderboards() async throws -> LeaderboardResult {
        let leaders = try await databaseManager.fetchLeaderboards()
        let top10 = Array(leaders.sorted(by: { $0.count > $1.count }).prefix(10))
        let username = UserDefaults.standard.string(forKey: "username")
        
        // if let username = username, top10.contains(where: { _ in 0.username == username}) {
        if let username = username, !top10.contains(where: { $0.username == username }) {
            
            let user = leaders.first(where: { $0.username == username})
            return LeaderboardResult(user: user, top10: top10)
        } else {
            return LeaderboardResult(user: nil, top10: top10)
        }
        
    }
    
    enum LeaderboardViewModelError: Error {
        case unableToFetchUsername
    }
    private func postStepCountForUser() async throws {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            throw LeaderboardViewModelError.unableToFetchUsername
        }
        let steps = try await fetchCurrentWeekStepCount()
        try await databaseManager.postStepCountUpdateForUser(leader:
                                                                LeaderboardUser(username: username, count: Int(steps)))
    }
    private func fetchCurrentWeekStepCount() async throws -> Double {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchCurrentWeekStepCount { result in
                continuation.resume(with: result)
            }
        })
    }
    
}
