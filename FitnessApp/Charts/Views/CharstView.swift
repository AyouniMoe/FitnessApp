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
//                                BarMark(
//                                x: .value(data.date.formatted(), data.date,
//                                unit: .day), y: .value("Steps", data.count)
                                BarMark(
                                x: .value("Date", data.date, unit: .day),
                                y: .value("Steps", data.count)
                                )
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
                            ForEach(viewModel.ytdChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date,
                                                  unit: .month), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .oneYear:
                    VStack {
                        ChartDataView(average: viewModel.oneYearAverage, total: viewModel.oneYearTotal)
                        Chart {
                            ForEach(viewModel.oneYearChartData) { data in
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
        alert("Oops", isPresented: $viewModel.presentError, actions: {
            Text("Ok")
        }, message: {
            Text("We ran into an error fetching your data. Please make sure you allow access and try again.")
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CharstView()
}

//
////CHATGPT fixed code
//
//import SwiftUI
//import Charts
//
//struct ChartsView: View {
//    @StateObject var viewModel = ChartsViewModel()
//    @State var selectedChart: ChartOptions = .oneWeek
//    
//    var body: some View {
//        VStack {
//            Text("Charts")
//                .font(.largeTitle)
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//            
//            ZStack {
//                switch selectedChart {
//                case .oneWeek:
//                    VStack {
//                        ChartDataView(average: viewModel.oneWeekAverage, total: viewModel.oneWeekTotal)
//                        
//                        Chart {
//                            ForEach(viewModel.mockWeekChartData) { data in
//                                BarMark(
//                                    x: .value("Date", data.date, unit: .day),
//                                    y: .value("Steps", data.count)
//                                )
//                            }
//                        }
//                    }
//                case .oneMonth:
//                    VStack {
//                        ChartDataView(average: viewModel.oneMonthAverage, total: viewModel.oneMonthTotal)
//                        Chart {
//                            ForEach(viewModel.mockOneMonthData) { data in
//                                BarMark(
//                                    x: .value("Date", data.date, unit: .day),
//                                    y: .value("Steps", data.count)
//                                )
//                            }
//                        }
//                    }
//                case .threeMonth:
//                    VStack {
//                        ChartDataView(average: viewModel.threeMonthAverage, total: viewModel.threeMonthTotal)
//                        Chart {
//                            ForEach(viewModel.mockThreeMonthData) { data in
//                                BarMark(
//                                    x: .value("Date", data.date, unit: .day),
//                                    y: .value("Steps", data.count)
//                                )
//                            }
//                        }
//                    }
//                case .yearToDate:
//                    VStack {
//                        ChartDataView(average: viewModel.ytdAverage, total: viewModel.ytdTotal)
//                        Chart {
//                            ForEach(viewModel.ytdChartData) { data in
//                                BarMark(
//                                    x: .value("Date", data.date, unit: .month),
//                                    y: .value("Steps", data.count)
//                                )
//                            }
//                        }
//                    }
//                case .oneYear:
//                    VStack {
//                        ChartDataView(average: viewModel.oneYearAverage, total: viewModel.oneYearTotal)
//                        Chart {
//                            ForEach(viewModel.oneYearChartData) { data in
//                                BarMark(
//                                    x: .value("Date", data.date, unit: .month),
//                                    y: .value("Steps", data.count)
//                                )
//                            }
//                        }
//                    }
//                }
//            }
//            .foregroundColor(.purple)
//            .frame(maxHeight: 400)
//            .padding(.horizontal)
//            
//            HStack {
//                ForEach(ChartOptions.allCases, id: \.self) { option in
//                    Button(action: {
//                        withAnimation {
//                            selectedChart = option
//                        }
//                    }) {
//                        Text(option.rawValue)
//                            .padding()
//                            .foregroundColor(selectedChart == option ? .white : .green)
//                            .background(selectedChart == option ? .green : .clear)
//                            .cornerRadius(10)
//                    }
//                }
//            }
//        }
//        .alert("Oops", isPresented: $viewModel.presentError, actions: {
//            Button("Ok", role: .cancel) { }
//        }, message: {
//            Text("We ran into an error fetching your data. Please make sure you allow access and try again.")
//        })
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//    }
//}
//
//#Preview {
//    ChartsView()
//}

