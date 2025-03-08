//
//  PaywallView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/6/25.
//

import SwiftUI
import RevenueCat





struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PaywallViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Premium Membership")
                .font(.largeTitle)
                .bold()
            
            Text("Lets get you on a path of Cardiovascular health recovery")
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "person.and.background.dotted")
                    
                    Text("Get a personalized Cardiologist on demand who knows all your health history")
                        .lineLimit(2)
                        .font(.system(size: 14))
                }
                HStack {
                    Image(systemName: "person.and.background.dotted")
                    
                    Text("Get a personalized Cardiologist on demand who knows all your health history")
                        .lineLimit(2)
                        .font(.system(size: 14))
                }
                HStack {
                    Image(systemName: "person.and.background.dotted")
                    
                    Text("Get a personalized Cardiologist on demand who knows all your health history")
                        .lineLimit(2)
                        .font(.system(size: 14))
                }
            }
            Spacer()
            
            HStack {
                if let offering = viewModel.currentOffering {
                    ForEach(offering.availablePackages) { package in
                        Button {
                            Purchases.shared.purchase(package: package) {
                                (transaction, customerInfo, error, userCancelled) in
                                if customerInfo?.entitlements["Premium"]?.isActive == true {
                                    dismiss()
                                }
                            }
                        } label: {
                            VStack(spacing: 8) {
                                Text(package.storeProduct.subscriptionPeriod?
                                    .durationTitle ?? "Subscription")
                                Text(package.storeProduct.localizedPriceString)
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .padding()
                        .frame(height: 100)
                        
                        .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.green)
                        )
                    }
                }
            }
            
        }
        .padding(.horizontal, 40)
        
        Button {
            Purchases.shared.restorePurchases { customerInfo, error in
                if customerInfo?.entitlements["Premium"]?.isActive == true {
                    dismiss()
                }
            }
        } label: {
            Text("Restore Purchases")
                .foregroundColor(.green)
                .underline()
        }
        Spacer()
        HStack{
            Spacer()
        Link("Terms of Use (ELUA)", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
            Spacer()
        Link("Privacy Policy", destination: URL(string: "https://github.com/AyouniMoe/FitnessApp")!)
            Spacer()
    }
        .frame(maxHeight: .infinity, alignment: .top)
    
    }
}

#Preview {
    PaywallView()
}
