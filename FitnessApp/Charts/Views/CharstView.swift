//
//  Historic.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI
import Charts

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
                    VStack {
                        ChartDataView(average: viewModel.oneWeekAverage, total: viewModel.oneWeekTotal)
                        
                        Chart {
                            ForEach(viewModel.mockWeekChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .oneMonth:
                    VStack {
                        ChartDataView(average: viewModel.oneMonthAverage, total: viewModel.oneMonthTotal)
                        Chart {
                            ForEach(viewModel.mockOneMonthData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                                  unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .threeMonth:
                    VStack {
                        ChartDataView(average: viewModel.ThreeMonthAverage, total: viewModel.threeMonthTotal)
                        Chart {
                            ForEach(viewModel.mockThreeMonthData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                                  unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .yearToDate:
                    VStack {
                        ChartDataView(average: viewModel.ytdAverage, total: viewModel.ytdTotal)
                        Chart {
                            ForEach(viewModel.mockWeekChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                                  unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .oneYear:
                    VStack {
                        ChartDataView(average: viewModel.oneYearAverage, total: viewModel.oneYearTotal)
                        Chart {
                            ForEach(viewModel.mockYTDChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                                  unit: .month), y: .value("Steps", data.count))
                            }
                        }
                    }
                }
            }
            .foregroundColor(.purple)
            .frame(maxHeight: 400)
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
