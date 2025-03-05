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
    @Published var workouts = [
        
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 2, title: "Walk", image: "figure.run", tintColor: .purple, duration: "5 mins", date: "Aug 11", calories: "512 Kcal"),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .cyan, duration: "1 mins", date: "Aug 19", calories: "512 Kcal"),
    ]
    
    var mockActivities = [
        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9,812"),
        Activity(title: "Today", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "9,8120"),
        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9,812"),
        Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.run", tintColor: .purple, amount: "104,812"),
    ]
    var mockWorkouts: [Workout] = [
        
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 2, title: "Walk", image: "figure.run", tintColor: .purple, duration: "5 mins", date: "Aug 11", calories: "512 Kcal"),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .cyan, duration: "1 mins", date: "Aug 19", calories: "512 Kcal"),
    ]
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaysSteps()
                fetchCurrentWeekActivities()
                fetchRecentWorkouts()
                
            } catch {
                print(error.localizedDescription)
            }
        }
            
        
    }
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                    let activity = Activity(title: "Calories Burned", subtitle: "today", image: "flame", tintColor: .red, amount: calories.formattedNumberString())
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
                print("Full error: \(failure)")

            }
        }
    }
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
                print("Full error: \(failure)")

            }
        }
    }
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            switch result {
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = hours
                }
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
                print("Full error: \(failure)")

            }
            
        }
    }
    
   // MARK: Fitness Activity
    func fetchTodaysSteps(){
        healthManager.fetchTodaySteps { result in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.activities.append(activity)
                }
            case.failure(let failure):
                print("Error: \(failure.localizedDescription)")
                print("Full error: \(failure)")
            }
            
        }
    }
    func fetchCurrentWeekActivities() {
        healthManager.fetchCurrentWeekWorkoutStats { result in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async {
                    self.activities.append(contentsOf: activities)
                }
            case.failure(let failure):
                print("Error: \(failure.localizedDescription)")
                print("Full error: \(failure)")
            }
                
            }
        }
    
    //MARK: Recent Workouts
    func fetchRecentWorkouts() {
        healthManager.fetchWorkoutsForMonth(month: Date()) { result in
        switch result {
        case .success(let workouts):
            DispatchQueue.main.async {
                self.workouts = Array(workouts.prefix(4))
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
        }
    }
    }

