//
//  PaywallView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/6/25.
//

//import SwiftUI
//
//
//
//
//
//
//struct PaywallView: View {
//    @Environment(\.dismiss) var dismiss
//    @StateObject var viewModel = PaywallViewModel()
//    @Binding var isPremium: Bool
//    
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Premium Membership")
//                .font(.largeTitle)
//                .bold()
//            
//            Text("Lets get you on a path of Cardiovascular health recovery")
//            Spacer()
//            
//            VStack(spacing: 36) {
//                HStack {
//                    Image(systemName: "person.and.background.dotted")
//                    
//                    Text("Get a personalized AI Cardiologist on demand who knows all your health history")
//                        .lineLimit(2)
//                        .font(.system(size: 14))
//                        .minimumScaleFactor(0.6)
//                }
//                HStack {
//                    Image(systemName: "person.and.background.dotted")
//                    
//                    Text("Earn points when you follow the recommendations")
//                        .lineLimit(2)
//                        .font(.system(size: 14))
//                        .minimumScaleFactor(0.6)
//                }
//                HStack {
//                    Image(systemName: "person.3.fill")
//                    
//                    Text("Get access to other users anonymous self experimentation results")
//                        .lineLimit(2)
//                        .font(.system(size: 14))
//                        .minimumScaleFactor(0.6)
//                }
//            }
//            Spacer()
//            
//            VStack(spacing: 12) {
//                if let offering = viewModel.currentOffering {
//                    ForEach(offering.availablePackages) { package in
//                        Button {
//                            Task {
//                                do {
//                                    try await viewModel.purchase(package: package)
//                                    isPremium = true
//                                    dismiss()
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
//                            }
//                            //                            Purchases.shared.purchase(package: package) {
//                            //                                (transaction, customerInfo, error, userCancelled) in
//                            //                                if customerInfo?.entitlements["Premium"]?.isActive == true {
//                            //                                    dismiss()
//                            //                                }
//                            //                            }
//                            
//                        } label: {
//                            VStack(spacing: 8) {
//                                Text(package.storeProduct.subscriptionPeriod?
//                                    .durationTitle ?? "Subscription")
//                                .font(.title3)
//                                .bold()
//                                Text(package.storeProduct.localizedPriceString)
//                                    
//                            }
//                            .foregroundcolor(.white)
//                            .frame(maxWidth: .infinity)
//                            
//                        }
//                        .padding(.vertical)
//                        .background(
//                            RoundedRectangle(cornerRadius: 15)
//                            //                            .stroke(lineWidth: 2)
//                                .foregroundColor(.green)
//                                .shadow(radius: 3)
//                        )
//                    }
//                }
//            }
//            
//        }
//        .padding(.horizontal)
//        
//        Button {
//            Task {
//                do {
//                    try await viewModel.restorePurchases()
//                    isPremium = true
//                    dismiss
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        } label: {
//            Text("Restore Purchases")
//                .foregroundColor(.green)
//                .underline()
//        }
//        .padding()
//        Spacer()
//        
//        HStack(spacing: 16) {
//            Link("Terms of Service", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
//            Circle()
//                .frame(maxWidth: 8)
//            Link("Privacy Policy", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
//        }
//        .foregroundColor(.green)
//    }
//        .frame(maxHeight: .infinity, alignment: .top)
//        .padding(.top)
//    }
//
//
//#Preview {
//    PaywallView(isPremium: .constant(false))
//}

//GPT fixes
import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PaywallViewModel()
    @Binding var isPremium: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Premium Membership")
                .font(.largeTitle)
                .bold()

            Text("Lets get you on a path of Cardiovascular health recovery")
            Spacer()

            VStack(spacing: 36) {
                HStack {
                    Image(systemName: "person.and.background.dotted")
                    Text("Get a personalized AI Cardiologist on demand who knows all your health history")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .minimumScaleFactor(0.6)
                }
                HStack {
                    Image(systemName: "person.and.background.dotted")
                    Text("Earn points when you follow the recommendations")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .minimumScaleFactor(0.6)
                }
                HStack {
                    Image(systemName: "person.3.fill")
                    Text("Get access to other users anonymous self experimentation results")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .minimumScaleFactor(0.6)
                }
            }
            Spacer()

            VStack(spacing: 12) {
                if let offering = viewModel.currentOffering {
                    ForEach(offering.availablePackages) { package in
                        Button {
                            Task {
                                do {
                                    try await viewModel.purchase(package: package)
                                    isPremium = true
                                    dismiss()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        } label: {
                            VStack(spacing: 8) {
                                Text(package.storeProduct.subscriptionPeriod?.durationTitle ?? "Subscription")
                                    .font(.title3)
                                    .bold()
                                Text(package.storeProduct.localizedPriceString)
                            }
                            .foregroundColor(.white) // Fix: Changed `.foregroundcolor` to `.foregroundColor`
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.green)
                                .shadow(radius: 3)
                        )
                    }
                }
            }

            Button {
                Task {
                    do {
                        try await viewModel.restorePurchases()
                        isPremium = true
                        dismiss() // Fix: Changed `dismiss` to `dismiss()`
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Restore Purchases")
                    .foregroundColor(.green)
                    .underline()
            }
            .padding()
            Spacer()

            HStack(spacing: 16) {
                Link("Terms of Service", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
                Circle()
                    .frame(width: 8, height: 8) // Fix: Added width & height explicitly
                Link("Privacy Policy", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
            }
            .foregroundColor(.green)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
}

#Preview {
    PaywallView(isPremium: .constant(false))
}

