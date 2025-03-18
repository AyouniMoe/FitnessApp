//
//  WorkoutCard.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/3/25.
//

import SwiftUI

struct WorkoutCard: View {
    @State var workout: Workout
    
    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tintColor)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(20)
                
            VStack(spacing: 16) {
                HStack {
                    Text(workout.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(workout.duration)
                    
                }
                HStack {
                    Text(workout.date)
                    Spacer()
                    Text(workout.calories)
                }
               
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutCard(workout: Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"))
}
