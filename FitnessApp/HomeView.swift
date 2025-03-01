//
//  HomeView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI

struct HomeView: View {
    @State var  calories: Int = 123
    @State var  active: Int = 52
    @State var  stand: Int = 8
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Welcome to the ultimate path to your Cardiovascular Health")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calories")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.red)
                            
                            Text("123 Kcal")
                                .bold()
                            
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.green)
                            
                            Text("52 mins")
                                .bold()
                            
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stand")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.blue)
                            
                            Text("8 hours")
                                .bold()
                            
                        }
                        
                        
                    }
                    Spacer()
                    
                    ZStack {
                        ProgressCircleView(progress: $calories, goal: 600, color: .red)
                        
                        ProgressCircleView(progress: $active, goal: 60, color: .green)
                            .padding(.all, 20)
                        ProgressCircleView(progress: $stand, goal: 600, color: .blue)
                            .padding(.all, 40)
                    }
                   .padding(.horizontal)
                    Spacer()
                }
                .padding(.horizontal)
                    
            }
        }
    }
}

#Preview {
    HomeView()
}
