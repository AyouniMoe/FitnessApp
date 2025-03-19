//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/3/25.
//

import Foundation
import HealthKit

class HomeViewModel: ObservableObject {
    
    let healthManager = HealthManager.shared
    
    @Published var  calories: Int = 0
    @Published var  exercise: Int = 0
    @Published var  stand: Int = 0
    @Published var activities = [Activity]()
    @Published var workouts = [Workout]()
    @Published var showAlert = false
    
//    var mockActivities = [
//        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9,812"),
//        Activity(title: "Today", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "9,8120"),
//        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9,812"),
//        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.run", tintColor: .purple, amount: "104,812"),
//    ]
//    var mockWorkouts: [Workout] = [
//        
//        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
//        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
//        Workout(id: 2, title: "Walk", image: "figure.run", tintColor: .purple, duration: "5 mins", date: "Aug 11", calories: "512 Kcal"),
//        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .cyan, duration: "1 mins", date: "Aug 19", calories: "512 Kcal"),
//    ]
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                
                async let fetchCalories: () = try await fetchTodayCalories()
                async let fetchExercise: () = try await fetchTodayExerciseTime()
                async let fetchStand: () = try await fetchTodayStandHours()
                async let fetchSteps: () = try await fetchTodaySteps()
                async let fetchActivities: () = try await fetchCurrentWeekActivities()
                async let fetchWorkouts: () = try await fetchRecentWorkouts()
                
                let (_, _, _, _, _, _) = (try await fetchCalories, try await fetchExercise, try await fetchStand, try await fetchSteps, try await fetchActivities, try await fetchWorkouts )
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
        
                    self.showAlert = true
                }
            }
        }
            
        
    }
    
    func fetchTodayCalories() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchTodayCaloriesBurned { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let calories):
                    DispatchQueue.main.async {
                        self.calories = Int(calories)
                        let activity = Activity(title: "Calories Burned", subtitle: "today", image: "flame", tintColor: .red, amount: calories.formattedNumberString())
                        self.activities.append(activity)
                        continuation.resume()
                    }
                case .failure(let failure):
                    
                    DispatchQueue.main.async {
                        
                        let activity = Activity(title: "Calories Burned", subtitle: "today", image: "flame", tintColor: .red, amount: "---")
                        self.activities.append(activity)
                        continuation.resume(throwing: failure)
                        
                    }
                    
                }
            }
        }) as Void
    }
    func fetchTodayExerciseTime() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchTodayExerciseTime { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let exercise):
                    DispatchQueue.main.async {
                        self.exercise = Int(exercise)
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                    

                }
            }
        }) as Void
    }
    func fetchTodayStandHours() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchTodayStandHours { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let hours):
                    DispatchQueue.main.async {
                        self.stand = hours
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)

                }
                
            }
        }) as Void
    }
    
    
   // MARK: Fitness Activity
    func fetchTodaySteps() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchTodaySteps { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let activity):
                    DispatchQueue.main.async {
                        self.activities.append(activity)
                        continuation.resume()
                    }
                case.failure(let failure):
                    DispatchQueue.main.async {
                        self.activities.append(Activity(title: "Today Steps", subtitle: "Goal: 800", image: "figure.walk", tintColor: .green, amount: "---"))
                        continuation.resume(throwing: failure)
                    }
                    
                }
                
            }
        }) as Void
    }
    func fetchCurrentWeekActivities() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchCurrentWeekWorkoutStats { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let activities):
                    DispatchQueue.main.async {
                        self.activities.append(contentsOf: activities)
                        continuation.resume()
                    }
                case.failure(let failure):
                    continuation.resume(throwing: failure)
                }
                    
                }
        }) as Void
    }
    
    //MARK: Recent Workouts
    func fetchRecentWorkouts() async throws {
        try await withCheckedThrowingContinuation ({ continuation in
            healthManager.fetchWorkoutsForMonth(month: Date()) { [weak self] result in
                guard let self = self else { return }
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts = Array(workouts.prefix(4))
                    continuation.resume()
                }
            case .failure(let failure):
                continuation.resume(throwing: failure)
            }
            }
        
        }) as Void
    }
}

