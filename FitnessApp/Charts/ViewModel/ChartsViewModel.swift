//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/5/25.
//

import Foundation

class ChartsViewModel: ObservableObject {
    
    //    var mockWeekChartData = [
    //        DailyStepModel(date: Date(), count: 10000),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-1, to: Date()) ?? Date(), count: 4800),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-2, to: Date()) ?? Date(), count: 4983),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-3, to: Date()) ?? Date(), count: 3989),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-4, to: Date()) ?? Date(), count: 3489),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-5, to: Date()) ?? Date(), count: 3948),
    //        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-6,
    //                to: Date()) ?? Date(), count: 9075)
    //    ]
    //    var mockYTDChartData = [
    //        MonthlyStepModel(date: Date(), count: 10000),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-1, to: Date()) ?? Date(), count: 48000),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-2, to: Date()) ?? Date(), count: 49803),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-3, to: Date()) ?? Date(), count: 48000),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-4, to: Date()) ?? Date(), count: 49083),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-5, to: Date()) ?? Date(), count: 40800),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-6, to: Date()) ?? Date(), count: 49803),
    //        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-7, to: Date()) ?? Date(), count: 48000),
    //    ]
    
    //@Published var oneWeekAverage = 129
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
    
    @Published var presentError = false
    
    init() {
        //        let mockOneMonth = mockDataForDays(days: 30)
        //        let mockThreeMonth = mockDataForDays(days: 90)
        //        DispatchQueue.main.async {
        //            self.mockOneMonthData = mockOneMonth
        //            self.mockThreeMonthData = mockThreeMonth
        //        }
        Task {
            do {
                async let oneWeek: () = try await fetchOneWeekStepData()
                async let oneMonth: () = try await fetchOneMonthStepData()
                async let threeMonths: () = try await fetchThreeMonthsStepData()
                async let ytdAndOneYear: () = try await fetchYTDAndOneYearChartData()
                
                _ = (try await oneWeek, try await oneMonth, try await threeMonths, try await ytdAndOneYear)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.presentError = true
                    
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
    
    func fetchOneMonthStepData() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchDailySteps(startDate: .oneMonthAgo) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let steps):
//                    DispatchQueue.main.async { [weak self] .indices
                    DispatchQueue.main.async {
                        self.oneMonthChartData = steps
                        
                        (self.oneMonthTotal, self.oneMonthAverage) = self.calculateAverageAndTotalFromData(steps: steps)
                        continuation.resume()
                    }
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                    
                }
                
            }
        }) as Void
        
        
    }
    
    func fetchThreeMonthsStepData() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            healthManager.fetchDailySteps(startDate: .threeMonthsAgo) { [weak self] result in
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


