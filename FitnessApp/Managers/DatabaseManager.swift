//  DatabaseManager.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/10/25.
//

import Foundation // Imports the Foundation framework, which provides essential data types and utilities
import FirebaseFirestore // Imports the Firebase Firestore framework, used for interacting with Firestore database

// This is the DatabaseManager class responsible for interacting with Firestore
class DatabaseManager {
    
    // This is a static property that holds a shared instance of DatabaseManager (Singleton pattern)
    static let shared = DatabaseManager()
    
    // The private init() prevents the creation of additional instances of DatabaseManager
    private init() {}
    
    // `database` is an instance of Firestore, which provides methods to interact with the Firestore database
    let database = Firestore.firestore()
    
    // `weeklyLeaderboard` generates the name of the Firestore collection for the current week's leaderboard
    let weeklyLeaderboard = "\(Date().mondayDateFormat())-leaderboard"
    // `Date().mondayDateFormat()` is presumably a method that formats the current date to get the start of the week.
    // Example: If the current date is March 10, 2025, it might return "2025-03-10-leaderboard".

    // Fetch Leaderboards function to get all documents from the Firestore collection for the leaderboard
    func fetchLeaderboards() async throws -> [LeaderboardUser] {
        
        let snapshot = try await database.collection(weeklyLeaderboard).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: LeaderboardUser.self) })
    }
    
    // Post (update) Leaderboard for current user: This function updates the user's step count in the leaderboard
    func postStepCountUpdateFor(username: String, count: Int) async throws {
        // Creates a new LeaderboardUser instance with the provided username and step count
        let leader = LeaderboardUser(username: username, count: count)
        
        // Encodes the `LeaderboardUser` instance into a format that Firestore can store (e.g., dictionary)
        let data = try Firestore.Encoder().encode(leader)
        
        // Updates (or adds) a document in the Firestore collection for the current week's leaderboard
        // The document is identified by the username of the user, and the encoded `data` is saved into it
        // The `merge: false` argument ensures that the document will be completely overwritten (not merged) if it exists
        try await database.collection(weeklyLeaderboard).document(username).setData(data, merge: false)
    }
}
