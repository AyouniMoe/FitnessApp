//
//  MonthWorkoutView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/15/25.
//

import SwiftUI

class MonthWorkoutsViewModel:  ObservableObject {
    
    @Published var selectedMonth = 0
    @Published var selectedDate = Date()
    @Published var workouts: [Workout] = []
    @Published var currentMonthWorkouts = [
        Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
        Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal"),
    Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: "Aug 1", calories: "512 Kcal")]
    
    func updateSelectedDate() {
        self.selectedDate = Calendar.current.date(byAdding: .month, value: selectedMonth, to: Date()) ?? Date()
        
    }
    
}


struct MonthWorkoutView: View {
    
    @StateObject var viewModel = MonthWorkoutsViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        viewModel.selectedMonth -= 1
                    }
                    
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                }
                Spacer()
                
                Text(viewModel.selectedDate.monthAndYearFormat())
                    .font(.title)
                    .frame(maxWidth: 250)
                
                Spacer()
                Button {
                    viewModel.selectedMonth += 1
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                        .opacity(viewModel.selectedMonth >= 0 ? 0.5 : 1)
                }
                .disabled(viewModel.selectedMonth >= 0)
                Spacer()
            }
            ScrollView(.vertical, showsIndicators: false) {ForEach(viewModel.currentMonthWorkouts, id: \.self) { workout in WorkoutCard(workout: workout)
            }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .onChange (of: viewModel.selectedMonth) { _ in viewModel.updateSelectedDate()
            
        }
    }
}

#Preview {
    MonthWorkoutView()
}
