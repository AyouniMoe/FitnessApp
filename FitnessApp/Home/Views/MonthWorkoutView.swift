//
//  MonthWorkoutView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/15/25.
//

//import SwiftUI
//
//class MonthWorkoutsViewModel:  ObservableObject {
//
//    @Published var selectedMonth = 0
//    @Published var selectedDate = Date()
//    var fetchedMonths: Set<String> = []
//    @Published var workouts: [Workout] = []
//    @Published var currentMonthWorkouts = [Workout
//                                           //        Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: Date(), calories: "512 Kcal"),
//                                           //        Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: Date(), calories: "512 Kcal"),
//                                           //    Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: Date(), calories: "512 Kcal"),
//                                           //        Workout(title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 mins", date: Date(), calories: "512 Kcal")
//                                           //
//    ]()
//
//    @Published var showAlert = false
//
//    init() {
//        Task {
//            do {
//                try await fetchWorkoutsForMonth()
//            } catch {
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.showAlert = true
//                }
//            }
//        }
//    }
//
//
//    
//    func updateSelectedDate() {
//        self.selectedDate = Calendar.current.date(byAdding: .month, value: selectedMonth, to: Date()) ?? Date()
//        if fetchedMonths.contains(selectedDate.monthAndYearFormat()) {
//            self.currentMonthWorkouts = workouts.filter( { $0.date.monthAndYearFormat() == selectedDate.monthAndYearFormat() })
//        } else {
//            Task {
//                do {
//                    try await fetchWorkoutsForMonth()
//                } catch {
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self = self else { return }
//                        self.showAlert = true
//                    }
//                }
//            }
//            
//        }
//        func fetchWorkoutsForMonth() async throws {
//            try await withCheckedThrowingContinuation({ continuation in
//                HealthManager.shared.fetchWorkoutsForMonth(month: selectedDate) { result in
//                    switch result {
//                    case .success(let workouts):
//                        DispatchQueue.main.async { [weak self] in
//                            guard let self = self else { return }
//                            self.workouts.append(contentsOf: workouts)
//                            self.fetchedMonths.insert(self.selectedDate.monthAndYearFormat())
//                            self.currentMonthWorkouts = self.workouts.filter( { $0.date.monthAndYearFormat() == self.selectedDate.monthAndYearFormat() })
//                            continuation.resume()
//                        }
//                    case .failure(_):
//                        DispatchQueue.main.async { [weak self] in
//                            guard let self = self else { return }
//                            self.showAlert = true
//                            continuation.resume()
//                        }
//                    }
//                }
//            }) as Void
//        }
//    }
//    
//    
//    struct MonthWorkoutView: View {
//        
//        @StateObject var viewModel = MonthWorkoutsViewModel()
//        
//        var body: some View {
//            VStack {
//                HStack {
//                    Spacer()
//                    
//                    Button {
//                        withAnimation {
//                            viewModel.selectedMonth -= 1
//                        }
//                        
//                    } label: {
//                        Image(systemName: "arrow.left.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 32, height: 32)
//                            .foregroundColor(.green)
//                    }
//                    Spacer()
//                    
//                    Text(viewModel.selectedDate.monthAndYearFormat())
//                        .font(.title)
//                        .frame(maxWidth: 250)
//                    
//                    Spacer()
//                    Button {
//                        viewModel.selectedMonth += 1
//                    } label: {
//                        Image(systemName: "arrow.right.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 32, height: 32)
//                            .foregroundColor(.green)
//                            .opacity(viewModel.selectedMonth >= 0 ? 0.5 : 1)
//                    }
//                    .disabled(viewModel.selectedMonth >= 0)
//                    Spacer()
//                }
//                ScrollView(.vertical, showsIndicators: false) {ForEach(viewModel.currentMonthWorkouts, id: \.self) { workout in WorkoutCard(workout: workout)
//                }
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//            .padding(.vertical)
//            .onChange (of: viewModel.selectedMonth) { _ in
//                viewModel.updateSelectedDate()
//                
//            }
//            .alert("Oops", isPresented: $viewModel.showAlert) {
//                Text("Ok")
//                
//            } message: {
//                Text("Unable to load workouts for \(viewModel.selectedDate.monthAndYearFormat()). Please make sure you havbe workouts for the selected month and try again.")
//            }
//        }
//    }
//    
//    #Preview {
//        MonthWorkoutView()
//    }
//}
// GPT FIXED THE ERROR Cannot find 'fetchWorkoutsForMonth' in scope
import SwiftUI



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
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.currentMonthWorkouts, id: \.self) { workout in
                    WorkoutCard(workout: workout)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .onChange(of: viewModel.selectedMonth) { _ in
            viewModel.updateSelectedDate()
        }
        .alert("Oops", isPresented: $viewModel.showAlert) {
            Text("Ok")
        } message: {
            Text("Unable to load workouts for \(viewModel.selectedDate.monthAndYearFormat()). Please make sure you have workouts for the selected month and try again.")
        }
    }
}

#Preview {
    MonthWorkoutView()
}
