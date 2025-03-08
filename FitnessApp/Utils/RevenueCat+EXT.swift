//
//  RevenueCat+EXT.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/7/25.
//

import RevenueCat

extension SubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return "Daily"
        case .week: return "Weekly"
        case .month: return "Monthly"
        case .year: return "Annual"
            @unknown default: return "unknown"
        }
    }
}
