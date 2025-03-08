//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI
import RevenueCat

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    @State var isPremium = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
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
        }
        . onAppear {
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

