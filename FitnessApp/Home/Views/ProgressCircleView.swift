//
//  ProgressCircleView.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 2/28/25.
//

import SwiftUI

struct ProgressCircleView: View {
    @Binding var progress: Int
    var goal: Int
    var color: Color
    private let width: CGFloat = 20
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: width)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress) / CGFloat(goal))
                .stroke(color, style: StrokeStyle(lineWidth: width, lineCap:
                        .round))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
            
        }
        .padding()
    }
}

 struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: .constant(100), goal: 200, color: .red)
    }
}

