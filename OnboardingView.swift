//
//  OnboardingView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 2/17/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            TabView {
       
                VStack(spacing: 20) {
               
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color(hex: "#7CA982"))
                    
                    Text("Track your symptoms")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#243E36"))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                    }) {
                        Text("Swipe")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                // Learn Screen
                VStack(spacing: 20) {
                    // Brain Image
                    Image(systemName: "brain.head.profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color(hex: "#7CA982"))
                    
                    Text("Learn more about managing your health effectively")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#243E36"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        
                    }) {
                        Text("Swipe")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                // Manage Screen
                VStack(spacing: 20) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(hex: "#7CA982"))
                    
                    Text("Get notifications to track your schedule and never miss a check-in")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#243E36"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // NavigationLink for "Get Started" button
                    NavigationLink(destination: AuthChoiceView()) {
                        Text("Get Started")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .tabViewStyle(PageTabViewStyle())
            .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        }
    }
}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView() // No binding needed for preview
    }
}
