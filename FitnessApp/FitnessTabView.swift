//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI
import RevenueCat

struct FitnessTabView: View {
    @AppStorage("username") var username: String?
    @State var selectedTab = "Home"
    @State var isPremium = false
    @State var showTerms = true
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(isPremium: $isPremium)
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                    
                }
            CharstView()
                .tag("Charts")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    
                    Text("Charts")
                }
            LeaderboardView(showTerms: $showTerms)
                .tag("Leaderboards")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Leaderboards")
                }
            ProfileView()
                .tag("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
        }
        .tint(.green)
        . onAppear {
            print(username)
            showTerms = username == nil
            Purchases.shared.getCustomerInfo { customerInfo, error in
                isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            }
        }
    }
}

struct FitnessTabView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessTabView()
    }
}

