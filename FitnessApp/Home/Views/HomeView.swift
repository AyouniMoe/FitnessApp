//
//  HomeView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI




struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @Binding var isPremium: Bool
    @State var showPaywall = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome to the ultimate path to your Cardiovascular Health")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.red)
                                
                                Text("\(viewModel.calories)")
                                    .bold()
                                
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.green)
                                
                                Text("\(viewModel.exercise)")
                                    .bold()
                                
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.blue)
                                
                                Text("\(viewModel.stand)")
                                    .bold()
                                
                            }
                            
                            
                        }
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $viewModel.calories, goal: 600, color: .red)
                            
                            ProgressCircleView(progress: $viewModel.exercise, goal: 60, color: .green)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $viewModel.stand, goal: 12, color: .blue)
                                .padding(.all, 40)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            if isPremium {
                            } else {
                                showPaywall = true
                            }
                            
                        } label: {
                            Text ("Show More")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                        
                    }
                    //                    .padding(.horizontal)
                    //
                    //                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    //                        ForEach(viewModel.activities, id: \.id) { activity in
                    //                            ActivityCard(activity: activity)
                    //                        }
                    //                    }
                    .padding(.horizontal)
                    
                    if !viewModel.activities.isEmpty {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(viewModel.activities, id: \.title) {
                                activity in
                                ActivityCard(activity: activity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        
                        if isPremium {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Text ("Show More")
                                    .padding(.all, 10)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .cornerRadius(20)
                            }
                        } else {
                            Button {
                                showPaywall = true
                                
                            } label: {
                                Text ("Show More")
                                    .padding(.all, 10)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVStack {
                        ForEach(viewModel.workouts, id: \.id) { workout in
                            WorkoutCard(workout: workout)}
                    }
                    
                }
                .padding(.bottom)
            }
            //{
            //{
            
            .alert("Oops", isPresented: $viewModel.presentError, actions: {
                Text("Ok")
                
            }, message: {
                Text("There was an issue fetching some of your data. Some health tracking requires an Apple Watch. Please make sure your Apple Watch is turned on and paired with your iPhone.")
            })
            
            .sheet(isPresented: $showPaywall) {
                PaywallView(isPremium: $isPremium)
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(isPremium: .constant(false))
        }
    }
    
    
}
