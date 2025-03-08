//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI
import RevenueCat

@main
struct FitnessApp: App {
    
    init() {
        Purchases.logLevel = .debug
        
        Purchases.configure(withAPIKey: "appl_GTAYAeABzVycyUzBmhsyDKdPYhz")
        // vid paused at 3:27.46
    }
    
    var body: some Scene {
        WindowGroup {
            FitnessTabView()
                .onAppear {
                    Purchases.shared.getOfferings { (offerings, error) in
                        if let packages = offerings?.current?.availablePackages {
                            print(packages.first?.offeringIdentifier)
                        }
                    }
                }
        }
    }
}

