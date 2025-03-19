//
//  DailyStepModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/5/25.
//

import Foundation

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
