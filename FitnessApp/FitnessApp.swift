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
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FitnessApp: App {
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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

