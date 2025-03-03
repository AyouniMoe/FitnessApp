//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/3/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
     var  calories: Int = 123
     var  active: Int = 52
     var  stand: Int = 8
    
    var mockActivities = [
        Activity(id: 0, title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9,812"),
        Activity(id: 1, title: "Today", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "9,8120"),
        Activity(id: 2, title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9,812"),
        Activity(id: 3, title: "Today Steps", subtitle: "Goal 12,000", image: "figure.run", tintColor: .purple, amount: "104,812"),
    ]
    var mockWorkouts: [Workout] = [
        
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .red, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(id: 2, title: "Walk", image: "figure.run", tintColor: .purple, duration: "5 mins", date: "Aug 11", calories: "512 Kcal"),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .cyan, duration: "1 mins", date: "Aug 19", calories: "512 Kcal"),
    ]
}
