//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI


struct ActivityCard: View {
    @State var activity: Activity?
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack{
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let activity = activity { // Safely unwrap the optional
                            Text(activity.title)
                        }

                        
                        if let activity = activity {
                            Text(activity.subtitle)
                                .font(.caption)
                        }

                    }
                    
                    Spacer()
                    
                    if let activity = activity {
                        Image(systemName: activity.image)
                            .foregroundColor(activity.tintColor)
                    }

                }
                if let activity = activity {
                    Text(activity.amount)
                        .font(.title)
                        .bold()
                        .padding()
                }


            }
            .padding()
        }
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCard(activity: Activity(title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9,812"))

    }
}

