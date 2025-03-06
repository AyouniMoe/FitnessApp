//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/5/25.
//

import Foundation

class ChartsViewModel: ObservableObject {
    
    var mockWeekChartData = [
        DailyStepModel(date: Date(), count: 10000),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-1, to: Date()) ?? Date(), count: 4800),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-2, to: Date()) ?? Date(), count: 4983),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-3, to: Date()) ?? Date(), count: 3989),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-4, to: Date()) ?? Date(), count: 3489),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-5, to: Date()) ?? Date(), count: 3948),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-6,
                to: Date()) ?? Date(), count: 9075)
    ]
    var mockYTDChartData = [
        MonthlyStepModel(date: Date(), count: 10000),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-1, to: Date()) ?? Date(), count: 48000),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-2, to: Date()) ?? Date(), count: 49803),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-3, to: Date()) ?? Date(), count: 48000),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-4, to: Date()) ?? Date(), count: 49083),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-5, to: Date()) ?? Date(), count: 40800),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-6, to: Date()) ?? Date(), count: 49803),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value:-7, to: Date()) ?? Date(), count: 48000),
    ]

    @Published var oneWeekAverage = 129
    @Published var oneWeekTotal = 8223
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var oneMonthAverage = 0
    @Published var oneMonthTotal = 0
    
    @Published var mockThreeMonthData = [DailyStepModel]()
    @Published var ThreeMonthAverage = 0
    @Published var threeMonthTotal = 0
    
    @Published var ytdChartData = [MonthlyStepModel]()
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    
    
    @Published var oneYearChartData = [MonthlyStepModel]()
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
    
    let healthManager = HealthManager.shared
    
    init() {
        let mockOneMonth = mockDataForDays(days: 30)
        let mockThreeMonth = mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThreeMonth
        }
        fetchYTDAndOneYearChartData()
    }
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 500...15000) // Generating a random step count between 5000 and 15000
            let dailyStepData = DailyStepModel(date: currentDate, count:
                (randomStepCount))
            mockData.append(dailyStepData)
            
        }
        return mockData
    }
    func fetchYTDAndOneYearChartData() {
        healthManager.fetchYTDAndOneYearData { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.ytdChartData = result.ytd
                    self.oneYearChartData = result.oneYear
                    
                    self.ytdTotal = self.ytdChartData.reduce(0, { $0 + $1.count})
                    self.oneYearTotal = self.oneYearChartData.reduce(0, { $0 + $1.count})
                    
                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                    self.oneYearAverage = self.oneYearTotal / 12
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                
            }
        }
    }
}
