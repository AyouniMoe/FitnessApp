//
//  PaywallViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/7/25.
//

import Foundation
import RevenueCat


class PaywallViewModel: ObservableObject {
    @Published var currentOffering: Offering?
    
    init() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                print("Error fetching offerings: \(error.localizedDescription)")
            }
            
            if let offering = offerings?.current {
                DispatchQueue.main.async {
                    self.currentOffering = offering
                    print("Offering retrieved: \(offering)")
                }
            } else {
                print("No current offering available")
            }
        }
    }
}
