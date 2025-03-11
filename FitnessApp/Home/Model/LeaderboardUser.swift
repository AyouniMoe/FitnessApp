//
//  LeaderboardUser.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

import Foundation

struct LeaderboardUser: Codable, Identifiable {
    let id = UUID()
    let username: String
    let count: Int
}
