//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/5/25.
//

import Foundation

class ChartsViewModel: ObservableObject {
    
       
    @Published var oneWeekChartData = [DailyStepModel]()
    @Published var oneWeekAverage = 0
    @Published var oneWeekTotal = 0
    
    @Published var oneMonthChartData = [DailyStepModel]()
    @Published var OneMonthAverage = 0
    @Published var oneMonthTotal = 0
    
    @Published var ThreeMonthsChartData = [DailyStepModel]()
    @Published var ThreeMonthAverage = 0
    @Published var threeMonthTotal = 0
    
    @Published var ytdChartData = [MonthlyStepModel]()
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    
    @Published var oneYearChartData = [MonthlyStepModel]()
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
    
    let healthManager = HealthManager.shared
    
    @Published var showAlert = false
    
    init() {
        Task {
            do {
                async let oneWeek: () = try await fetchOneWeekStepData()
                
                // the fetchOneWeekStepData() below is supposed to be for OneMonth but that did not work so i replaced it with oneweekstepdata to avoid the error
                
                async let oneMonth: () = try await fetchOneWeekStepData()
                async let threeMonths: () = try await fetchThreeMonthsStepData()
                async let ytdAndOneYear: () = try await fetchYTDAndOneYearChartData()
                
                _ = (try await oneWeek, try await oneMonth, try await threeMonths, try await ytdAndOneYear)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showAlert = true
                    
                }
            }
        }
    }
    
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 500...15000) // Generating a random step count between 5000 and 15000
            let dailyStepData = DailyStepModel(date: currentDate, count:
                                                randomStepCount)
            mockData.append(dailyStepData)
            
        }
        return mockData
    }
    
    func calculateAverageAndTotalFromData(steps: [DailyStepModel]) -> (Int, Int) {
//        let total = steps.reduce(0, { $0 +1.count})
        let total = steps.reduce(0, { $0 + $1.count })

        let average = total / steps.count
        
        return (total, average)
    }
    
    func fetchOneWeekStepData() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchDailySteps(startDate: /*ADDED THIS HERE SINCE IT COULD HELP SOLVE THE PROBLEM*/ .startOfWeek/*oneWeekAgo*/) { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case.success(let steps):
//                    DispatchQueue.main.async { [weak self] .in
                    DispatchQueue.main.async {
                        self.oneWeekChartData = steps
                        (self.oneWeekTotal, self.oneWeekAverage) = self.calculateAverageAndTotalFromData(steps: steps)
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                }
            }
        }) as Void
        
        
    }
    
    //    func fetchOneWeekStepData() {
    //        healthManager.fetchDailySteps(startDate: .oneWeekAgo) { result in
    //            switch result {
    //            case.success(let steps):
    //                DispatchQueue.main.async { [weak self] .in
    //                    guard let self = self else {return}
    //                    self.oneWeekChartData = steps
    //                    (self.oneWeekTotal, self.oneWeekAverage) = self.calculateAverageAndTotalFromData(steps: steps)
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //            }
    //        }
    //    }
    
    
    // DELETED THIS FUNC BECAUSE IT WAS GIVING AN ERROR #1
    
    
//    func fetchOneMonthStepData() async throws {
//        try await withCheckedThrowingContinuation({ continuation in
//            healthManager.fetchDailySteps(startDate: .oneMonthAgo) { [weak self] result in
//                guard let self = self else {return}
//                switch result {
//                case .success(let steps):
////                    DispatchQueue.main.async { [weak self] .indices
//                    DispatchQueue.main.async {
//                        self.oneMonthChartData = steps
//                        
//                        (self.oneMonthTotal, self.oneMonthAverage) = self.calculateAverageAndTotalFromData(steps: steps)
//                        continuation.resume()
//                    }
//                case .failure(let failure):
//                    continuation.resume(throwing: failure)
//                    
//                }
//                
//            }
//        }) as Void
//        
//        
//    }
    
    func fetchThreeMonthsStepData() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchDailySteps(startDate: /*.threeMonthsAgo this was marked out because it gave an error*/ .startOfWeek /*.startof week added instead because that works*/ ) { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let steps):
                    DispatchQueue.main.async {
                        self.ThreeMonthsChartData = steps
                        
                        (self.threeMonthTotal, self.ThreeMonthAverage) = self.calculateAverageAndTotalFromData(steps: steps)
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                    
                }
            }
        }) as Void
        
        
    }
    func fetchYTDAndOneYearChartData() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchYTDAndOneYearChartData { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let result):
                    DispatchQueue.main.async {
                        self.ytdChartData = result.ytd
                        self.oneYearChartData = result.oneYear
                        
                        self.ytdTotal = self.ytdChartData.reduce(0, { $0 + $1.count})
                        self.oneYearTotal = self.oneYearChartData.reduce(0, { $0 + $1.count})
                        
                        self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                        self.oneYearAverage = self.oneYearTotal / 12
                        
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                    
                }
            }
        }) as Void
        
        
    }
    
    //    func fetchOneMonthStepData() {
    //        healthManager.fetchDailySteps(startDate: .oneMonthAgo) { resukt in
    //            switch result {
    //            case .success(let steps):
    //                DispatchQueue.main.async { [weak self] .indices
    //                    guard let self = self else {return}
    //                    self.OneMonthChartData = steps
    //
    //                    (self.oneMonthTotal, self.oneMonthAverage) = self.calculateAverageAndTotalFromData(steps: steps)
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //                //STOPED HERE STILL NEED TO COPY FROM VID TO WHATS BELOW
    //            }
    //
    //        }
    //    }
    
    //    func fetchThreeMonthsStepData() {
    //        healthManager.fetchDailySteps(startDate: .threeMonthsAgo) { resukt in
    //            switch result {
    //            case .success(let steps):
    //                DispatchQueue.main.async { [weak self] in
    //                    guard let self = self else {return}
    //                    self.ThreeMonthsChartData = steps
    //
    //                    (self.threeMonthTotal, self.ThreeMonthAverage) = self.calculateAverageAndTotalFromData(steps: steps)
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //
    //                }
    //            }
    //
    //        }
    
    //    func fetchYTDAndOneYearChartData() {
    //        healthManager.fetchYTDAndOneYearData { result in
    //            switch result {
    //            case .success(let result):
    //                DispatchQueue.main.async {
    //                    self.ytdChartData = result.ytd
    //                    self.oneYearChartData = result.oneYear
    //
    //                    self.ytdTotal = self.ytdChartData.reduce(0, { $0 + $1.count})
    //                    self.oneYearTotal = self.oneYearChartData.reduce(0, { $0 + $1.count})
    //
    //                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
    //                    self.oneYearAverage = self.oneYearTotal / 12
    //                }
    //            case .failure(let failure):
    //                print(failure.localizedDescription)
    //
    //            }
    //        }
    //    }
    
    
}


