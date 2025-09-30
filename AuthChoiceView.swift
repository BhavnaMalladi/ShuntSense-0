//
//  AuthChoiceView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 2/17/25.
//

import SwiftUI

struct AuthChoiceView: View {
    var body: some View {
        NavigationStack{
            VStack(spacing: 40) {
                // Title at the top
                Text("ShuntSense")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                    .padding(.top, 60)
                
                // Logo Image below the title
                Image("TransparentShuntSenseLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .shadow(color: Color(hex: "#7CA982").opacity(0.5), radius: 10, x: 0, y: 5)
                
                Spacer()
                
                // Buttons for Log In and Sign Up
                VStack(spacing: 20) {
                    NavigationLink(destination: LoginView()){
                        Text("Log In")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        }
    }
}


struct AuthChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        AuthChoiceView()
    }
}
