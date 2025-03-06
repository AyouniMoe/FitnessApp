//
//  Historic.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI
import Charts

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Double
}

enum ChartOptions: String, CaseIterable {
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonths = "3M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
}


class ChartsViewModel: ObservableObject {
    
    var mockChartData = [
        DailyStepModel(date: Date(), count: 10000),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-1, to: Date()) ?? Date(), count: 4800),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-2, to: Date()) ?? Date(), count: 4983),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-3, to: Date()) ?? Date(), count: 3989),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-4, to: Date()) ?? Date(), count: 3489),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-5, to: Date()) ?? Date(), count: 3948),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value:-6,
                to: Date()) ?? Date(), count: 9075)
    ]
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var mockThreeMonthData = [DailyStepModel]()
    
    init() {
        let mockOneMonth = mockDataForDays(days: 30)
        let mockThreeMonths = mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThreeMonths
        }
    }
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 500...15000) // Generating a random step count between 5000 and 15000
            let dailyStepData = DailyStepModel(date: currentDate, count:
                Double(randomStepCount))
            mockData.append(dailyStepData)
            
        }
        return mockData
    }
}

struct CharstView: View {
    @StateObject var viewModel = ChartsViewModel()
    @State var selectedChart: ChartOptions = .oneWeek
    
    var body: some View {
        VStack {
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ZStack {
                switch selectedChart {
                case .oneWeek:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date,
                            unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .oneMonth:
                    Chart {
                        ForEach(viewModel.mockOneMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date,
                            unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .threeMonths:
                    Chart {
                        ForEach(viewModel.mockThreeMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date,
                            unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .yearToDate:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date,
                            unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .oneYear:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date,
                            unit: .day), y: .value("Steps", data.count))
                        }
                    }
                }
            }
            .foregroundColor(.green)
            .frame(maxHeight: 350)
            .padding(.horizontal)
            
            HStack {
                ForEach(ChartOptions.allCases, id:\.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation { selectedChart = option
                        }
                    }
                    .padding()
                    .foregroundColor(selectedChart == option ? .white : .green)
                    .background(selectedChart == option ? .green : .clear)
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CharstView()
}
